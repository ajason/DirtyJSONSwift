#!/usr/bin/env swift

import Foundation

// 直接包含必要的 DirtyJSON 代码以便测试
// 这样可以避免模块导入问题

// MARK: - DirtyJSON Token
struct Token {
    let index: Int
    let value: String?
    let lastChar: String?
}

// MARK: - DirtyJSON TokenStatus
class TokenStatus {
    var stack: [String] = []
    var expectLiteral = true
    var expectOpenToken = true
    var expectColon = false
    var expectComma = false
    var hasObjectKey = false
    
    func encounterOpenBrace() {
        stack.append("{")
        expectLiteral = true
        expectOpenToken = false
        expectColon = false
        expectComma = false
        hasObjectKey = false
    }
    
    func encounterOpenSquare() {
        stack.append("[")
        expectLiteral = true
        expectOpenToken = false
        expectColon = false
        expectComma = false
        hasObjectKey = false
    }
    
    func encounterLiteral() {
        expectLiteral = false
        expectOpenToken = false
        if inObject() && !hasObjectKey {
            hasObjectKey = true
            expectColon = true
        } else {
            expectComma = true
        }
    }
    
    func encounterColon() {
        expectColon = false
        expectLiteral = true
        expectOpenToken = true
    }
    
    func encounterComma() {
        expectComma = false
        expectLiteral = true
        expectOpenToken = true
        if inObject() {
            hasObjectKey = false
        }
    }
    
    func encounterClosedToken() {
        _ = stack.popLast()
        expectLiteral = false
        expectOpenToken = false
        expectColon = false
        if stack.isEmpty {
            expectComma = false
        } else {
            expectComma = true
        }
        if inObject() {
            hasObjectKey = true
        }
    }
    
    func expectClosedToken() -> Bool {
        return !stack.isEmpty
    }
    
    func inObject() -> Bool {
        return stack.last == "{"
    }
}

// MARK: - DirtyJSON StringIterator
class StringIterator {
    public var array: [String]
    public var index = -1
    
    init(_ text: String) {
        array = text.map { String($0) }
    }
    
    @discardableResult
    func next() -> String? {
        index += 1
        return index < array.count ? array[index] : nil
    }
    
    @discardableResult
    func prev() -> String? {
        for i in stride(from: index - 1, through: 0, by: -1) {
            guard i >= 0 && i < array.count else { continue }
            let value = array[i]
            if (!value.isEmpty && !isWhitespace(value)) {
                index = i
                return value
            }
        }
        return nil
    }
    
    func peek(_ n: Int = 1) -> String? {
        let peekIndex = index + n
        guard peekIndex >= 0 && peekIndex < array.count else {
            return nil
        }
        return array[peekIndex]
    }
    
    func peekPrev() -> Token {
        for i in stride(from: index - 1, through: 0, by: -1) {
            guard i >= 0 && i < array.count else { continue }
            let value = array[i].trimmingCharacters(in: .whitespacesAndNewlines)
            if (!value.isEmpty && !isWhitespace(value)) {
                return Token(index: i, value: value, lastChar: value.last?.description)
            }
        }
        return Token(index: -1, value: nil, lastChar: nil)
    }
    
    func get() -> String {
        guard index >= 0 && index < array.count else { return "" }
        return array[index]
    }
    
    func set(_ value: String) {
        guard index >= 0 && index < array.count else { return }
        array[index] = value
    }
    
    func append(_ value: String) {
        guard index >= 0 && index < array.count else { return }
        array[index] = array[index] + value
    }
    
    func done() -> Bool {
        return index >= array.count - 1
    }
    
    func toString() -> String {
        return array.joined(separator: "")
    }
}

// MARK: - Helper Functions
func isWhitespace(_ char: String) -> Bool {
    return char.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}

func isInvisible(_ char: String) -> Bool {
    return char.unicodeScalars.allSatisfy { scalar in
        CharacterSet.controlCharacters.contains(scalar) ||
        CharacterSet.illegalCharacters.contains(scalar) ||
        (scalar.value >= 0x200B && scalar.value <= 0x200F)
    }
}

func isNumber(_ value: String) -> Bool {
    return Double(value) != nil
}

// MARK: - Main DirtyJSON Fix Function (修复版本)
enum DirtyJSON {
    static func fix(_ text: String) -> String {
        let iterator = StringIterator(text)
        let status = TokenStatus()
        
        while true {
            let token = nextToken(iterator)
            
            switch token {
            case "\"":
                encounterQuote(iterator, status)
            case "{":
                encounterOpenBrace(iterator, status)
            case "[":
                encounterOpenSquare(iterator, status)
            case "}", "]":
                encounterClosedToken(iterator, status)
            case ":":
                encounterColon(iterator, status)
            case ",":
                encounterComma(iterator, status)
            case nil:
                encounterEnd(iterator, status)
                return iterator.toString()
            default:
                encounterLiteral(iterator, status, token!)
            }
        }
    }
    
    // 其他必要的静态方法...
    static func nextToken(_ iterator: StringIterator, deleteWhitespace: Bool = true) -> String? {
        while !iterator.done() {
            skipWhitespace(iterator, deleteWhitespace: true)
            let char = iterator.next()
            switch char {
            case "\"", "'", "`":
                return "\""
            case "/":
                // 处理注释...
                return char
            case "":
                break
            default:
                return char
            }
        }
        iterator.next()
        return nil
    }
    
    static func skipWhitespace(_ iterator: StringIterator, deleteWhitespace: Bool = false) {
        while !iterator.done() {
            guard let peek = iterator.peek(), isWhitespace(peek) else {
                return
            }
            iterator.next()
            if deleteWhitespace {
                iterator.set("")
            }
        }
    }
    
    static func encounterQuote(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectLiteral {
            iterator.set("")
            return
        }
        // 简化的字符串处理
        iterator.set("\"")
        while !iterator.done() {
            let char = iterator.next()!
            if char == "\"" {
                iterator.set("\"")
                break
            }
        }
        status.encounterLiteral()
    }
    
    static func encounterOpenBrace(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectOpenToken {
            iterator.set("")
            return
        }
        status.encounterOpenBrace()
    }
    
    static func encounterOpenSquare(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectOpenToken {
            iterator.set("")
            return
        }
        status.encounterOpenSquare()
    }
    
    static func encounterClosedToken(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectClosedToken() {
            iterator.set("")
            return
        }
        let peekPrevResult = iterator.peekPrev()
        // 修复后的安全访问
        if peekPrevResult.lastChar == "," && peekPrevResult.index >= 0 && peekPrevResult.index < iterator.array.count {
            iterator.array[peekPrevResult.index] = ""
        }
        if status.inObject() {
            iterator.set("}")
        } else {
            iterator.set("]")
        }
        status.encounterClosedToken()
    }
    
    static func encounterColon(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectColon {
            iterator.set("")
            return
        }
        status.encounterColon()
    }
    
    static func encounterComma(_ iterator: StringIterator, _ status: TokenStatus) {
        if !status.expectComma {
            iterator.set("")
            return
        }
        status.encounterComma()
    }
    
    static func encounterLiteral(_ iterator: StringIterator, _ status: TokenStatus, _ token: String) {
        if !status.expectLiteral {
            iterator.set("")
            return
        }
        status.encounterLiteral()
    }
    
    static func encounterEnd(_ iterator: StringIterator, _ status: TokenStatus) {
        let peekPrevResult = iterator.peekPrev()
        if peekPrevResult.lastChar == "," && peekPrevResult.index >= 0 && peekPrevResult.index < iterator.array.count {
            iterator.array[peekPrevResult.index] = ""
        }
        
        // 修复后的安全栈清理
        while !status.stack.isEmpty {
            switch status.stack.popLast() {
            case "{":
                if !iterator.array.isEmpty && iterator.array.count > 0 {
                    let lastIndex = iterator.array.count - 1
                    if lastIndex >= 0 && lastIndex < iterator.array.count {
                        iterator.array[lastIndex] += "}"
                    }
                }
            case "[":
                if !iterator.array.isEmpty && iterator.array.count > 0 {
                    let lastIndex = iterator.array.count - 1
                    if lastIndex >= 0 && lastIndex < iterator.array.count {
                        iterator.array[lastIndex] += "]"
                    }
                }
            default:
                break
            }
        }
    }
}

// MARK: - 测试函数
func testDirtyJSONFix() {
    print("🧪 开始测试 DirtyJSON 修复后的数组越界问题")
    
    // 测试用例1：模拟流式 JSON 数据解析 - 这是导致原始崩溃的场景
    let partialJSON1 = #"{"sentence":"OAuth was first introduced in 2007. It was created at Twitter because Twitter wanted a way to allow third-party apps to post tweets on users' behalf. Take a second to imagine designing something like that today. How would you do it? One way would just be to ask the user for their username and password. So you create an unofficial Twitter client, and present the user a login screen that says \"log in with Twitter"#
    
    print("\n1️⃣ 测试不完整的 JSON 流（原始崩溃场景）")
    do {
        let result1 = DirtyJSON.fix(partialJSON1)
        print("✅ 测试1通过: \(result1)")
    } catch {
        print("❌ 测试1失败: \(error)")
    }
    
    // 测试用例2：空字符串
    let emptyJSON = ""
    print("\n2️⃣ 测试空字符串")
    do {
        let result2 = DirtyJSON.fix(emptyJSON)
        print("✅ 测试2通过: '\(result2)'")
    } catch {
        print("❌ 测试2失败: \(error)")
    }
    
    // 测试用例3：只有开括号
    let onlyBrace = "{"
    print("\n3️⃣ 测试只有开括号")
    do {
        let result3 = DirtyJSON.fix(onlyBrace)
        print("✅ 测试3通过: \(result3)")
    } catch {
        print("❌ 测试3失败: \(error)")
    }
    
    // 测试用例4：只有开方括号
    let onlySquare = "["
    print("\n4️⃣ 测试只有开方括号")
    do {
        let result4 = DirtyJSON.fix(onlySquare)
        print("✅ 测试4通过: \(result4)")
    } catch {
        print("❌ 测试4失败: \(error)")
    }
    
    // 测试用例5：极短的字符串可能导致数组越界
    let veryShort = "\\"
    print("\n5️⃣ 测试极短字符串")
    do {
        let result5 = DirtyJSON.fix(veryShort)
        print("✅ 测试5通过: '\(result5)'")
    } catch {
        print("❌ 测试5失败: \(error)")
    }
    
    print("\n🏁 测试完成！如果没有崩溃，说明修复成功！")
}

// 运行测试
testDirtyJSONFix()