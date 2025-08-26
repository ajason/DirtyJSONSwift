#!/usr/bin/env swift

import Foundation

// 导入 DirtyJSON 模块
// 注意：这里假设你已经将 DirtyJSON 代码编译成模块或直接包含在项目中

// 模拟原崩溃场景的测试用例
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
    
    // 测试用例2：包含特殊字符的不完整 JSON
    let partialJSON2 = #"{"cards":[{"word":"Investment","sentence":"🚨BREAKING: Chief Investment Officer Keith Fitz-Gerald says "Betting against Elon is like betting against Steve Jobs" 👀\"#
    
    print("\n2️⃣ 测试包含特殊字符的不完整 JSON")
    do {
        let result2 = DirtyJSON.fix(partialJSON2)
        print("✅ 测试2通过: \(result2)")
    } catch {
        print("❌ 测试2失败: \(error)")
    }
    
    // 测试用例3：空字符串
    let emptyJSON = ""
    print("\n3️⃣ 测试空字符串")
    do {
        let result3 = DirtyJSON.fix(emptyJSON)
        print("✅ 测试3通过: '\(result3)'")
    } catch {
        print("❌ 测试3失败: \(error)")
    }
    
    // 测试用例4：只有开括号
    let onlyBrace = "{"
    print("\n4️⃣ 测试只有开括号")
    do {
        let result4 = DirtyJSON.fix(onlyBrace)
        print("✅ 测试4通过: \(result4)")
    } catch {
        print("❌ 测试4失败: \(error)")
    }
    
    // 测试用例5：只有开方括号
    let onlySquare = "["
    print("\n5️⃣ 测试只有开方括号")
    do {
        let result5 = DirtyJSON.fix(onlySquare)
        print("✅ 测试5通过: \(result5)")
    } catch {
        print("❌ 测试5失败: \(error)")
    }
    
    // 测试用例6：极短的字符串可能导致数组越界
    let veryShort = "\\"
    print("\n6️⃣ 测试极短字符串")
    do {
        let result6 = DirtyJSON.fix(veryShort)
        print("✅ 测试6通过: '\(result6)'")
    } catch {
        print("❌ 测试6失败: \(error)")
    }
    
    // 测试用例7：嵌套结构突然结束
    let nestedIncomplete = #"{"a":{"b":[{"c":#
    print("\n7️⃣ 测试嵌套结构突然结束")
    do {
        let result7 = DirtyJSON.fix(nestedIncomplete)
        print("✅ 测试7通过: \(result7)")
    } catch {
        print("❌ 测试7失败: \(error)")
    }
    
    print("\n🏁 测试完成！")
}

// 如果直接运行此脚本
testDirtyJSONFix()