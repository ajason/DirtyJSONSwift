import XCTest
@testable import DirtyJSON

final class DirtyJSONTests: XCTestCase {
    func testFixChar0() {
        XCTAssertEqual(DirtyJSON.fix(""), "")
    }
    
    func testFixChar1() {
        XCTAssertEqual(DirtyJSON.fix(" "), "");
        XCTAssertEqual(DirtyJSON.fix("{"), "{}");
        XCTAssertEqual(DirtyJSON.fix("["), "[]");
        XCTAssertEqual(DirtyJSON.fix("}"), "");
        XCTAssertEqual(DirtyJSON.fix("]"), "");
        XCTAssertEqual(DirtyJSON.fix(":"), "");
        XCTAssertEqual(DirtyJSON.fix(","), "");
        XCTAssertEqual(DirtyJSON.fix("'"), "");
        XCTAssertEqual(DirtyJSON.fix("\""), "");
        XCTAssertEqual(DirtyJSON.fix("`"), "");
        XCTAssertEqual(DirtyJSON.fix("0"), "0");
        XCTAssertEqual(DirtyJSON.fix("9"), "9");
        XCTAssertEqual(DirtyJSON.fix("-"), "\"-\"");
        XCTAssertEqual(DirtyJSON.fix("."), "\".\"");
        XCTAssertEqual(DirtyJSON.fix("a"), "\"a\"");
        XCTAssertEqual(DirtyJSON.fix("e"), "\"e\"");
        XCTAssertEqual(DirtyJSON.fix("【"), "[]");
        XCTAssertEqual(DirtyJSON.fix("】"), "");
        XCTAssertEqual(DirtyJSON.fix("："), "");
    }
    
    func testFixChar2() {
        // start from {
        XCTAssertEqual(DirtyJSON.fix("{{"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{]"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{:"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{,"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{\""), "{}")
        XCTAssertEqual(DirtyJSON.fix("{'"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{`"), "{}")
        
        // start from [
        XCTAssertEqual(DirtyJSON.fix("[{"), "[{}]")
        XCTAssertEqual(DirtyJSON.fix("[}"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[]"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[:"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[,"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[\""), "[]")
        XCTAssertEqual(DirtyJSON.fix("['"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[`"), "[]")
        XCTAssertEqual(DirtyJSON.fix("[0"), "[0]")
        XCTAssertEqual(DirtyJSON.fix("[9"), "[9]")
        XCTAssertEqual(DirtyJSON.fix("[-"), "[\"-\"]")
        XCTAssertEqual(DirtyJSON.fix("[."), "[\".\"]")
        XCTAssertEqual(DirtyJSON.fix("[a"), "[\"a\"]")
        XCTAssertEqual(DirtyJSON.fix("[【"), "[[]]")
        XCTAssertEqual(DirtyJSON.fix("[："), "[]")
        
        // start from }
        XCTAssertEqual(DirtyJSON.fix("}{"), "{}")
        XCTAssertEqual(DirtyJSON.fix("}}"), "")
        XCTAssertEqual(DirtyJSON.fix("}]"), "")
        XCTAssertEqual(DirtyJSON.fix("}:"), "")
        XCTAssertEqual(DirtyJSON.fix("},"), "")
        XCTAssertEqual(DirtyJSON.fix("}\""), "")
        XCTAssertEqual(DirtyJSON.fix("}'"), "")
        XCTAssertEqual(DirtyJSON.fix("}`"), "")
        XCTAssertEqual(DirtyJSON.fix("}0"), "0")
        XCTAssertEqual(DirtyJSON.fix("}9"), "9")
        XCTAssertEqual(DirtyJSON.fix("}-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("}."), "\".\"")
        XCTAssertEqual(DirtyJSON.fix("}a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("}【"), "[]")
        XCTAssertEqual(DirtyJSON.fix("}："), "")
        
        // start from ]
        XCTAssertEqual(DirtyJSON.fix("]{"), "{}")
        XCTAssertEqual(DirtyJSON.fix("]}"), "")
        XCTAssertEqual(DirtyJSON.fix("]]"), "")
        XCTAssertEqual(DirtyJSON.fix("]:"), "")
        XCTAssertEqual(DirtyJSON.fix("],"), "")
        XCTAssertEqual(DirtyJSON.fix("]\""), "")
        XCTAssertEqual(DirtyJSON.fix("}'"), "")
        XCTAssertEqual(DirtyJSON.fix("]`"), "")
        XCTAssertEqual(DirtyJSON.fix("]0"), "0")
        XCTAssertEqual(DirtyJSON.fix("]9"), "9")
        XCTAssertEqual(DirtyJSON.fix("]-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("]."), "\".\"")
        XCTAssertEqual(DirtyJSON.fix("]a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("]【"), "[]")
        XCTAssertEqual(DirtyJSON.fix("]："), "")
        
        // start from :
        XCTAssertEqual(DirtyJSON.fix(":{"), "{}")
        XCTAssertEqual(DirtyJSON.fix(":}"), "")
        XCTAssertEqual(DirtyJSON.fix(":]"), "")
        XCTAssertEqual(DirtyJSON.fix("::"), "")
        XCTAssertEqual(DirtyJSON.fix(":,"), "")
        XCTAssertEqual(DirtyJSON.fix(":\""), "")
        XCTAssertEqual(DirtyJSON.fix("}'"), "")
        XCTAssertEqual(DirtyJSON.fix(":`"), "")
        XCTAssertEqual(DirtyJSON.fix(":0"), "0")
        XCTAssertEqual(DirtyJSON.fix(":9"), "9")
        XCTAssertEqual(DirtyJSON.fix(":-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix(":."), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(":a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix(":【"), "[]")
        XCTAssertEqual(DirtyJSON.fix(":："), "")
        
        // start from ,
        XCTAssertEqual(DirtyJSON.fix(",{"), "{}")
        XCTAssertEqual(DirtyJSON.fix(",}"), "")
        XCTAssertEqual(DirtyJSON.fix(",]"), "")
        XCTAssertEqual(DirtyJSON.fix("::"), "")
        XCTAssertEqual(DirtyJSON.fix(",:"), "")
        XCTAssertEqual(DirtyJSON.fix(",'"), "")
        XCTAssertEqual(DirtyJSON.fix("}'"), "")
        XCTAssertEqual(DirtyJSON.fix(",:`"), "")
        XCTAssertEqual(DirtyJSON.fix(",0"), "0")
        XCTAssertEqual(DirtyJSON.fix(",9"), "9")
        XCTAssertEqual(DirtyJSON.fix(",-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix(",."), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(",a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix(",【"), "[]")
        XCTAssertEqual(DirtyJSON.fix(",："), "")
        
        // start from "
        XCTAssertEqual(DirtyJSON.fix("\"{"), "\"{\"")
        XCTAssertEqual(DirtyJSON.fix("\"}"), "\"}\"")
        XCTAssertEqual(DirtyJSON.fix("\"]"), "\"]\"")
        XCTAssertEqual(DirtyJSON.fix("\":"), "\":\"")
        XCTAssertEqual(DirtyJSON.fix("\","), "\",\"")
        XCTAssertEqual(DirtyJSON.fix("\"\""), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("\"'"), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("\"`"), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("\"0"), "\"0\"")
        XCTAssertEqual(DirtyJSON.fix("\"9"), "\"9\"")
        XCTAssertEqual(DirtyJSON.fix("\"-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("\"."), "\".\"")
        XCTAssertEqual(DirtyJSON.fix("\"a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("\"【"), "\"【\"")
        XCTAssertEqual(DirtyJSON.fix("\"："), "\"：\"")
        
        // start from `
        XCTAssertEqual(DirtyJSON.fix("`{"), "\"{\"")
        XCTAssertEqual(DirtyJSON.fix("`}"), "\"}\"")
        XCTAssertEqual(DirtyJSON.fix("`]"), "\"]\"")
        XCTAssertEqual(DirtyJSON.fix("`:") , "\":\"")
        XCTAssertEqual(DirtyJSON.fix("`,"), "\",\"")
        XCTAssertEqual(DirtyJSON.fix("`\""), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("`\'"), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("``"), "\"\"")
        XCTAssertEqual(DirtyJSON.fix("`0"), "\"0\"")
        XCTAssertEqual(DirtyJSON.fix("`9"), "\"9\"")
        XCTAssertEqual(DirtyJSON.fix("`-"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("`.`"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix("`a"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("`【"), "\"【\"")
        XCTAssertEqual(DirtyJSON.fix("`："), "\"：\"")
        
        // start from 0
        XCTAssertEqual(DirtyJSON.fix("0{"), "0")
        XCTAssertEqual(DirtyJSON.fix("0}"), "0")
        XCTAssertEqual(DirtyJSON.fix("0]"), "0")
        XCTAssertEqual(DirtyJSON.fix("0:"), "0")
        XCTAssertEqual(DirtyJSON.fix("0,"), "0")
        XCTAssertEqual(DirtyJSON.fix("0\""), "0")
        XCTAssertEqual(DirtyJSON.fix("0'"), "0")
        XCTAssertEqual(DirtyJSON.fix("0`"), "0")
        XCTAssertEqual(DirtyJSON.fix("00"), "00") // TODO: should be 0
        XCTAssertEqual(DirtyJSON.fix("09"), "09") // TODO: should be 9
        XCTAssertEqual(DirtyJSON.fix("0-"), "\"0-\"")
        XCTAssertEqual(DirtyJSON.fix("0."), "0.") // TODO: should be 0
        XCTAssertEqual(DirtyJSON.fix("0a"), "\"0a\"")
        XCTAssertEqual(DirtyJSON.fix("0【"), "0")
        XCTAssertEqual(DirtyJSON.fix("0:"), "0")
        
        // start from 9
        XCTAssertEqual(DirtyJSON.fix("90"), "90")
        XCTAssertEqual(DirtyJSON.fix("99"), "99")
        
        // start from -
        XCTAssertEqual(DirtyJSON.fix("-{"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-}"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-]"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-:"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-,"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-\""), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-'"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-`"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-0"), "-0") // TODO: should be 0
        XCTAssertEqual(DirtyJSON.fix("-9"), "-9")
        XCTAssertEqual(DirtyJSON.fix("--"), "\"--\"")
        XCTAssertEqual(DirtyJSON.fix("-."), "\"-.\"")
        XCTAssertEqual(DirtyJSON.fix("-a"), "\"-a\"")
        XCTAssertEqual(DirtyJSON.fix("-【"), "\"-\"")
        XCTAssertEqual(DirtyJSON.fix("-:"), "\"-\"")
        
        // start from .
        XCTAssertEqual(DirtyJSON.fix(".{"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".}"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".]"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".:"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".,") , "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".\""), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".'"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".."), "\"..\"")
        XCTAssertEqual(DirtyJSON.fix(".0"), ".0") // TODO: should be 0
        XCTAssertEqual(DirtyJSON.fix(".9"), ".9") // TODO: should be 0.9
        XCTAssertEqual(DirtyJSON.fix(".-"), "\".-\"")
        XCTAssertEqual(DirtyJSON.fix(".a"), "\".a\"")
        XCTAssertEqual(DirtyJSON.fix(".【"), "\".\"")
        XCTAssertEqual(DirtyJSON.fix(".:"), "\".\"")
        
        // start from a
        XCTAssertEqual(DirtyJSON.fix("a{"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a}"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a]"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a:"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a,"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a\""), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a'"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a."), "\"a.\"")
        XCTAssertEqual(DirtyJSON.fix("a0"), "\"a0\"")
        XCTAssertEqual(DirtyJSON.fix("a9"), "\"a9\"")
        XCTAssertEqual(DirtyJSON.fix("a-"), "\"a-\"")
        XCTAssertEqual(DirtyJSON.fix("a."), "\"a.\"")
        XCTAssertEqual(DirtyJSON.fix("aa"), "\"aa\"")
        XCTAssertEqual(DirtyJSON.fix("a【"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a:"), "\"a\"")
        XCTAssertEqual(DirtyJSON.fix("a"), "\"a\"")


    }
    
    func test1() {
        XCTAssertEqual(DirtyJSON.fix("tRue"), "true")
        XCTAssertEqual(DirtyJSON.fix("FalSE"), "false")
        XCTAssertEqual(DirtyJSON.fix("nULl"), "null")
        XCTAssertEqual(DirtyJSON.fix("{"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{  "), "{}")
        XCTAssertEqual(DirtyJSON.fix("  {"), "{}")
        XCTAssertEqual(DirtyJSON.fix("  {  "), "{}")
        XCTAssertEqual(DirtyJSON.fix("{{}}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("[[]]"), "[[]]")
        XCTAssertEqual(DirtyJSON.fix("[[], []]"), "[[],[]]")
        XCTAssertEqual(DirtyJSON.fix("{[]}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{[], []}"), "{},[]") // it looks strange
        XCTAssertEqual(DirtyJSON.fix("{[}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{]}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{:}"), "{}")
        XCTAssertEqual(DirtyJSON.fix("{,}"), "{}")
        
        XCTAssertEqual(DirtyJSON.fix("{a:}"), "{\"a\":null}")
        XCTAssertEqual(DirtyJSON.fix("{a:]"), "{\"a\":null}")
        XCTAssertEqual(DirtyJSON.fix("{:a}"), "{\"a\":null}")

        XCTAssertEqual(DirtyJSON.fix("{\"a\": 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{'a': 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{`a`: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{”a”: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{'a\": 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{「a」: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{「a「: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{‘a’: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{'\"a\"': 1}"), "{\"\\\"a\\\"\":1}")
        XCTAssertEqual(DirtyJSON.fix("{\"\"a\"\": 1}"), "{\"\\\"a\\\"\":1}")
        
        XCTAssertEqual(DirtyJSON.fix("{\"1\": 1}"), "{\"1\":1}")
        XCTAssertEqual(DirtyJSON.fix("{12: 3}"), "{\"12\":3}")
        XCTAssertEqual(DirtyJSON.fix("{'an \"example\"\t\u{10}\u{15}\n word': 1}"), "{\"an \\\"example\\\"\\t\\n word\":1}")
        XCTAssertEqual(DirtyJSON.fix("{\"an \"example\" word\": 1}"), "{\"an \\\"example\\\" word\":1}")
        XCTAssertEqual(DirtyJSON.fix("{a: 1}"), "{\"a\":1}")
        XCTAssertEqual(DirtyJSON.fix("{a: 1, c: d}"), "{\"a\":1,\"c\":\"d\"}")
        XCTAssertEqual(DirtyJSON.fix(
            "[1, 2, 3, \"a\", \"b\", \"c\", abc, TrUe, False, NULL, 1.23e10, 123abc, { 123:123 },]"),
            "[1,2,3,\"a\",\"b\",\"c\",\"abc\",true,false,null,1.23e10,\"123abc\",{\"123\":123}]")
        XCTAssertEqual(DirtyJSON.fix("{\"a\": 1, {\"b\": 2]]"), "{\"a\":1,\"b\":2}")
        XCTAssertEqual(DirtyJSON.fix("{,,,\"a\",,:, 1,,, {,,,\"b\",: 2,,,],,,],,,"), "{\"a\":1,\"b\":2}")
        XCTAssertEqual(DirtyJSON.fix("{\"a\": 1, b: [2, “3”:}]"), "{\"a\":1,\"b\":[2,\"3\"]}")
        XCTAssertEqual(DirtyJSON.fix("},{「a」:1,,b:[2,,“3”:},]},"), "{\"a\":1,\"b\":[2,\"3\"]}")
        XCTAssertEqual(DirtyJSON.fix("[\"quotes in \"quotes\" in quotes\"]"), "[\"quotes in \\\"quotes\\\" in quotes\"]")
        XCTAssertEqual(DirtyJSON.fix("{\"a\": 1, b:: [2, “3\":}] // this is a comment"), "{\"a\":1,\"b\":[2,\"3\"]}")
        XCTAssertEqual(DirtyJSON.fix("},{,key:：/*multiline\ncomment\nhere*/ “//value\",】， // this is an abnormal JSON"), "{\"key\":\"//value\"}")
    }
    
    func testIncomplete() {
        XCTAssertEqual(DirtyJSON.fix("{a: "), "{\"a\":null}")
    }
    
    func testStrings() {
        let s = "{\"s\":\"The term \\\"antiglare\\\" is derived from the combination of \\\"anti-\\\" meaning against or opposed to, and \\\"glare\\\" referring to a harsh, bright light that causes discomfort. The concept originated in the field of optics and has since been applied to various industries to improve visual comfort.\"}";
        XCTAssertEqual(DirtyJSON.fix(s), s)
    }
    
    func testFix1() {
        XCTAssertEqual(DirtyJSON.fix("{ test: 'this is a test', 'number': 1.23e10 }"), "{\"test\":\"this is a test\",\"number\":1.23e10}")
    }
    
    func testFix2() {
        XCTAssertEqual(DirtyJSON.fix("{ \"test\": \"some text \"a quote\" more text\"} "), "{\"test\":\"some text \\\"a quote\\\" more text\"}")
    }
    
    func testFix3() {
        XCTAssertEqual(DirtyJSON.fix("{\"test\": \"each \n on \n new \n line\"}"), "{\"test\":\"each \\n on \\n new \\n line\"}")
    }
    
    func testJsonDataWithComments() {
        let jsonDataWithComments = """
            {
                // This is a comment
                "name": "John",
                "age": 30
            }
        """
        XCTAssertEqual(DirtyJSON.fix(jsonDataWithComments), "{\"name\":\"John\",\"age\":30}")
    }
    
    func testJsonDataWithTrailingCommas() {
        let jsonDataWithTrailingCommas = """
            {
                "name": "John",
                "age": 30, // Notice this trailing comma
            }
        """
        XCTAssertEqual(DirtyJSON.fix(jsonDataWithTrailingCommas), "{\"name\":\"John\",\"age\":30}")
    }
    
    func testJsonDataWithMismatch() {
        let jsonDataWithMismatch = """
            {
                "name": "John",
                "age": 30,
                "friends": [
                    "Alice",
                    "Bob",
                } // this '}' should be ']'
            】// this abnormal square bracket  should be '}'
        """
        XCTAssertEqual(DirtyJSON.fix(jsonDataWithMismatch), "{\"name\":\"John\",\"age\":30,\"friends\":[\"Alice\",\"Bob\"]}")
    }
    
    func testUnfinishedJsonData() {
        let unfinishedJsonData = """
            {
                "name": "John",
                "age": 30,
                "friends": [
                    "Alice",
                    "Bob",
        """
        XCTAssertEqual(DirtyJSON.fix(unfinishedJsonData), "{\"name\":\"John\",\"age\":30,\"friends\":[\"Alice\",\"Bob\"]}")
    }
    
    func testImproperlyWrittenJSON() {
        let improperlyWrittenJSON = "},{「a」:1,,b:[2,,\"3\":},]},"
        XCTAssertEqual(DirtyJSON.fix(improperlyWrittenJSON), "{\"a\":1,\"b\":[2,\"3\"]}")
    }
    
    // MARK: - 数组越界修复回归测试
    
    /// 测试原始崩溃场景：流式 JSON 解析导致的数组越界
    func testArrayBoundsRegression_StreamingJSON() {
        // 这是导致原始崩溃的实际场景
        let partialStreamJSON = #"{"sentence":"OAuth was first introduced in 2007. It was created at Twitter because Twitter wanted a way to allow third-party apps to post tweets on users' behalf. Take a second to imagine designing something like that today. How would you do it? One way would just be to ask the user for their username and password. So you create an unofficial Twitter client, and present the user a login screen that says \"log in with Twitter"#
        
        // 应该不会崩溃，并且能产生合法的 JSON
        let result = DirtyJSON.fix(partialStreamJSON)
        XCTAssertFalse(result.isEmpty, "流式 JSON 修复后不应该为空")
        XCTAssertTrue(result.hasPrefix("{"), "修复后应该以 { 开头")
        XCTAssertTrue(result.hasSuffix("}"), "修复后应该以 } 结尾")
        
        // 验证修复后的 JSON 可以被正常解析
        XCTAssertNoThrow(try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []))
    }
    
    /// 测试极端边界条件：空字符串和单字符输入
    func testArrayBoundsRegression_EdgeCases() {
        // 空字符串
        XCTAssertNoThrow(DirtyJSON.fix(""))
        XCTAssertEqual(DirtyJSON.fix(""), "")
        
        // 单字符输入
        let singleChars = ["{", "}", "[", "]", "\"", "'", "`", "\\", ":", ",", " ", "\n", "\t"]
        for char in singleChars {
            XCTAssertNoThrow(DirtyJSON.fix(char), "处理单字符 '\(char)' 时不应崩溃")
        }
    }
    
    /// 测试嵌套结构中的数组越界
    func testArrayBoundsRegression_NestedStructures() {
        let nestedIncomplete = #"{"a":{"b":[{"c":"#
        let result = DirtyJSON.fix(nestedIncomplete)
        XCTAssertNoThrow(try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []))
        
        // 深层嵌套
        let deepNested = String(repeating: "{\"a\":", count: 50) + "1" + String(repeating: "}", count: 49)
        XCTAssertNoThrow(DirtyJSON.fix(deepNested))
        
        // 数组嵌套
        let arrayNested = String(repeating: "[", count: 50) + "1" + String(repeating: "]", count: 49)
        XCTAssertNoThrow(DirtyJSON.fix(arrayNested))
    }
    
    /// 测试极长输入的数组安全性
    func testArrayBoundsRegression_LongInputs() {
        // 极长的重复括号
        let longBraces = String(repeating: "{", count: 1000)
        XCTAssertNoThrow(DirtyJSON.fix(longBraces))
        
        let longBrackets = String(repeating: "[", count: 1000)
        XCTAssertNoThrow(DirtyJSON.fix(longBrackets))
        
        // 极长的字符串内容
        let longString = #"{"text":""# + String(repeating: "a", count: 10000)
        XCTAssertNoThrow(DirtyJSON.fix(longString))
    }
    
    /// 测试特殊字符和 Unicode 处理中的数组安全性
    func testArrayBoundsRegression_SpecialCharacters() {
        // Unicode 表情符号
        let emojiJSON = #"{"emoji":"😀💀🎉🚨"#
        XCTAssertNoThrow(DirtyJSON.fix(emojiJSON))
        
        // 换行符和控制字符
        let controlCharsJSON = "{\"text\":\"\n\t\r\u{08}\u{1F}"
        XCTAssertNoThrow(DirtyJSON.fix(controlCharsJSON))
        
        // 零宽字符
        let zeroWidthJSON = "{\"text\":\"\u{200B}\u{200C}\u{200D}\u{FEFF}"
        XCTAssertNoThrow(DirtyJSON.fix(zeroWidthJSON))
    }
    
    /// 测试 peekPrev 函数中的数组越界修复
    func testArrayBoundsRegression_PeekPrevFunction() {
        // 测试可能触发 peekPrev 边界问题的情况
        let trailingComma = "{\"a\":1,"
        XCTAssertNoThrow(DirtyJSON.fix(trailingComma))
        let result1 = DirtyJSON.fix(trailingComma)
        XCTAssertEqual(result1, "{\"a\":1}")
        
        // 测试连续的逗号
        let multipleCommas = "{\"a\":1,,,"
        XCTAssertNoThrow(DirtyJSON.fix(multipleCommas))
        
        // 测试结尾处的各种符号组合
        let endingSymbols = ["{\"a\":1:", "{\"a\":1,", "{\"a\":1}", "{\"a\":1]", "{\"a\":1\""]
        for symbol in endingSymbols {
            XCTAssertNoThrow(DirtyJSON.fix(symbol), "处理结尾符号 '\(symbol)' 时不应崩溃")
        }
    }
    
    /// 测试栈清理过程中的数组越界修复
    func testArrayBoundsRegression_StackClearing() {
        // 测试不匹配的括号组合，这些会触发栈清理逻辑
        let mismatchedBrackets = [
            "{[}]", "[{]}", "{{[", "[[{", "}]{[", "]}{[",
            "{\"a\":[{\"b\":", "[{\"a\":\"b\",", "{{{{", "[[[["
        ]
        
        for mismatch in mismatchedBrackets {
            XCTAssertNoThrow(DirtyJSON.fix(mismatch), "处理不匹配的括号 '\(mismatch)' 时不应崩溃")
            // 验证修复后的结果至少是有效的 JSON 结构
            let result = DirtyJSON.fix(mismatch)
            XCTAssertFalse(result.isEmpty, "修复后的结果不应为空")
        }
    }
    
    /// 压力测试：大量随机边界情况
    func testArrayBoundsRegression_StressTest() {
        let problematicInputs = [
            "", " ", "\t", "\n",
            "{", "}", "[", "]", ":", ",", "\"", "'", "`", "\\",
            "{{", "}}", "[[", "]]", "{}", "[]", "::", ",,",
            "{\"", "[\"", "}\"", "]\"", ":{", ",[", "}[", "]{",
            "{:}", "[:]", "{,}", "[,]", "{\"}", "[\"\"", 
            String(repeating: "{", count: 100),
            String(repeating: "[", count: 100),
            String(repeating: "}", count: 100),
            String(repeating: "]", count: 100)
        ]
        
        for (index, input) in problematicInputs.enumerated() {
            XCTAssertNoThrow(DirtyJSON.fix(input), "压力测试 #\(index) 输入 '\(input)' 时不应崩溃")
        }
    }
    
    /// 测试原日志中出现的具体错误场景
    func testArrayBoundsRegression_LogScenario() {
        // 模拟日志中的 AI 流式响应场景
        let aiStreamContent = #"{"sentence":"OAuth was first introduced in 2007. It was created at Twitter because Twitter wanted a way to allow third-party apps to post tweets on users' behalf. Take a second to imagine designing so"#
        XCTAssertNoThrow(DirtyJSON.fix(aiStreamContent))
        
        // 模拟处理过程中的中间状态
        let intermediateStates = [
            #"{"sentence":"OAuth"#,
            #"{"sentence":"OAuth was first"#,
            #"{"sentence":"OAuth was first introduced in 2007"#,
            #"{"sentence":"OAuth was first introduced in 2007. It was created at Twitter"#
        ]
        
        for state in intermediateStates {
            XCTAssertNoThrow(DirtyJSON.fix(state), "处理中间状态时不应崩溃")
            let result = DirtyJSON.fix(state)
            // 验证修复后的 JSON 可以被解析
            XCTAssertNoThrow(try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []))
        }
    }

    static var allTests = [
        ("testFixChar0", testFixChar0),
        ("testFixChar1", testFixChar1),
        ("testFixChar2", testFixChar2),
        ("test1", test1),
        ("testIncomplete", testIncomplete),
        ("testStrings", testStrings),
        ("testFix1", testFix1),
        ("testFix2", testFix2),
        ("testFix3", testFix3),
        ("testJsonDataWithComments", testJsonDataWithComments),
        ("testJsonDataWithCommas", testJsonDataWithTrailingCommas),
        ("testJsonDataWithMismatch", testJsonDataWithMismatch),
        ("testUnfinishedJsonData", testUnfinishedJsonData),
        ("testImproperlyWrittenJSON", testImproperlyWrittenJSON),
        // 数组越界回归测试
        ("testArrayBoundsRegression_StreamingJSON", testArrayBoundsRegression_StreamingJSON),
        ("testArrayBoundsRegression_EdgeCases", testArrayBoundsRegression_EdgeCases),
        ("testArrayBoundsRegression_NestedStructures", testArrayBoundsRegression_NestedStructures),
        ("testArrayBoundsRegression_LongInputs", testArrayBoundsRegression_LongInputs),
        ("testArrayBoundsRegression_SpecialCharacters", testArrayBoundsRegression_SpecialCharacters),
        ("testArrayBoundsRegression_PeekPrevFunction", testArrayBoundsRegression_PeekPrevFunction),
        ("testArrayBoundsRegression_StackClearing", testArrayBoundsRegression_StackClearing),
        ("testArrayBoundsRegression_StressTest", testArrayBoundsRegression_StressTest),
        ("testArrayBoundsRegression_LogScenario", testArrayBoundsRegression_LogScenario),
    ]
}
