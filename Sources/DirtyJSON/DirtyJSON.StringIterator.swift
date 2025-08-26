extension DirtyJSON {
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
                if (!value.isEmpty && !DirtyJSON.isWhitespace(value)) {
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
                if (!value.isEmpty && !DirtyJSON.isWhitespace(value)) {
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
}
