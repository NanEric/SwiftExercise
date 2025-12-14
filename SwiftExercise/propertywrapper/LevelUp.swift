//
//  LevelUp.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/11.
//

import Foundation

/*-------------------------      题目一       ------------------------------------*/
//进阶题：带逻辑的包装器
//@Validated：实现一个支持 “自定义验证规则” 的包装器，赋值时触发验证，不通过则抛出错误 / 回滚。要求：
//初始化时传入验证闭包 (Value) -> Bool；
//可选配置 “验证失败策略”（抛错 / 使用默认值 / 回滚旧值）；
//示例：
//swift
//// 验证手机号：11位数字
//@Validated(validator: { $0.count == 11 && $0.allSatisfy { $0.isNumber } }, fallback: "00000000000")
//var phoneNumber: String = "13800138000"
//
//phoneNumber = "123" // 触发 fallback，值变为 00000000000

@propertyWrapper
class Validated {
    typealias validClouse = (String) -> Bool
    private var phoneNumber: String
    private var validator: validClouse
    private var fallback: String

    var wrappedValue: String {
        set {
            print("set_")
            if validator(newValue) {
                phoneNumber = newValue
            } else {
                phoneNumber = fallback
            }
        }

        get {
            print("get_")
            return phoneNumber
        }
    }
  
    init(wrappedValue: String, validator: @escaping validClouse, fallback: String) {
        
        self.validator = validator
        self.fallback = fallback
        if validator(wrappedValue) {
            phoneNumber = wrappedValue
        } else {
            phoneNumber = fallback
        }
        
        print("init_")
        
    }
}


/*-------------------------      题目一 全部结束       ------------------------------------*/


class TestLevelUp {
    static func testValidated() {
        @Validated(validator: { $0.count == 11 && $0.allSatisfy { $0.isNumber } }, fallback: "00000000000")
        var phoneNumber: String = "13800138000"
        print("phoneNumber:\(phoneNumber)")
        
        print("assign new value....")
        phoneNumber = "123" // 触发 fallback，值变为 00000000000
        print("phoneNumber:\(phoneNumber)")
    }
}
