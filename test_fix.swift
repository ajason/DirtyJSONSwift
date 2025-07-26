#!/usr/bin/env swift

import Foundation

// 导入 DirtyJSON 模块
// 注意：这里假设你已经将 DirtyJSON 代码编译成模块或直接包含在项目中

// 模拟原崩溃场景的测试用例
func testDirtyJSONFix() {
    // 测试用例1：模拟流式 JSON 数据解析
    let partialJSON1 = #"{"cards":[{"word":"Investment","sentence":"🚨BREAKING: Chief Investment Officer Keith Fitz-Gerald says "Betting against Elon is like betting"#
    
    do {
        let result1 = DirtyJSON.fix(partialJSON1)
        print("✅ 测试1通过: \(result1)")
    } catch {
        print("❌ 测试1失败: \(error)")
    }
    
    // 测试用例2：包含特殊字符的不完整 JSON
    let partialJSON2 = #"{"cards":[{"word":"Investment","sentence":"🚨BREAKING: Chief Investment Officer Keith Fitz-Gerald says "Betting against Elon is like betting against Steve Jobs" 👀\"#
    
    do {
        let result2 = DirtyJSON.fix(partialJSON2)
        print("✅ 测试2通过: \(result2)")
    } catch {
        print("❌ 测试2失败: \(error)")
    }
    
    // 测试用例3：空字符串
    let emptyJSON = ""
    do {
        let result3 = DirtyJSON.fix(emptyJSON)
        print("✅ 测试3通过: \(result3)")
    } catch {
        print("❌ 测试3失败: \(error)")
    }
    
    // 测试用例4：只有开括号
    let onlyBrace = "{"
    do {
        let result4 = DirtyJSON.fix(onlyBrace)
        print("✅ 测试4通过: \(result4)")
    } catch {
        print("❌ 测试4失败: \(error)")
    }
}

// 如果直接运行此脚本
testDirtyJSONFix()