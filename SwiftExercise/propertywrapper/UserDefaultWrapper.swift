//
//  File.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/10.
//

import Foundation

/*-------------------------   题目一  ------------------------------------*/
//@UserDefault：实现一个属性包装器，用于简化 UserDefaults 的读写（支持默认值、指定 Key）。要求：
//1.支持 String/Int/Bool/Double 等基础类型；
//2.自动处理 Key（可自定义，默认使用属性名）；
//3.示例：
//@UserDefault(key: "user_name", defaultValue: "Guest")
//static var userName: String
//
//@UserDefault(defaultValue: 0)
//static var loginCount: Int

@propertyWrapper
class UserDefaultFake<T> {
    private var key: String
    private var defaultValue: T
    private let user_default = UserDefaults.standard
    
    init(key: String? = nil, defaultValue: T, file: String = #function, line: Int = #line) {
        self.key = key ?? "\(file):\(line)"
        
        self.defaultValue = defaultValue
    }
    
    var wrappedValue : T {
        get {
             let finalKey = key
            print("finalKey:" + finalKey)
             return user_default.value(forKey: finalKey) as? T ?? defaultValue
        }

        set {
            // 加锁防止userdefaults访问出错
            objc_sync_enter(self)
            defer {
                objc_sync_exit(self)
            }
            
            let finalKey = key
            print("finalKey:" + finalKey)
            user_default.setValue(newValue, forKey: finalKey)
        }
    }
    
//    // MARK: - 自动获取属性名（关键逻辑）
//    /// 自动推导当前包装的属性名（Swift 5.1+ 特性）
//    private var _propertyName: String {
//        // 通过 Mirror 反射获取外围实例的属性名
//        let mirror = Mirror(reflecting: self)
//        for case let (label?, value) in mirror.superclassMirror?.children ?? mirror.children {
//            if value as AnyObject === self as AnyObject {
//                return label
//            }
//        }
//        // 兜底：若反射失败，使用 UUID 避免冲突（实际开发中几乎不会触发）
//        return UUID().uuidString
//    }
}
/*-------------------------   题目一 全部结束  ------------------------------------*/


/*-------------------------      题目二       ------------------------------------*/
//@Clamped：实现一个 “数值范围限制” 包装器，确保属性值始终在指定区间内。要求：
//1.支持 Int/Float/Double；
//2.初始化时传入最小值和最大值；
//3.赋值超出范围时自动截断到边界值；
//4.示例：
//swift
//@Clamped(min: 0, max: 100)
//var score: Int = 80
//
//score = 120 // 实际值为 100
//score = -5  // 实际值为 0

@propertyWrapper
class Clamped<Type: Comparable> {
    private var defaultMaxValue: Type
    private var defaultMinValue: Type
    private var value: Type
    
    var wrappedValue: Type {
        set {
            value = min(max(newValue, defaultMinValue),defaultMaxValue)
        }
        
        get {
            return value
        }
    }
    
    init(wrappedValue: Type, min: Type, max: Type) {
        defaultMinValue = min
        defaultMaxValue = max
        value = Swift.min(defaultMaxValue,Swift.max(wrappedValue,min))
    }
}

/*-------------------------      题目二 全部结束 ------------------------------------*/

class TestWrapper {
    static func testUserDefault () {
        @UserDefaultFake(key: "user_name", defaultValue: "Guest")
        var userName: String
        
        @UserDefaultFake(defaultValue: 0)
        var loginCount: Int
        
        print("userName:" + userName + "," + "loginCount:" + "\(loginCount)")
        
        loginCount = 5
        
        print("new loginCount:" + "\(loginCount)")
    }
    
    static func testClamped() {
        @Clamped(min: 0, max: 100)
        var score: Int = 80
        print("score:\(score)")
        
        score = 120 // 实际值为 100
        print("score:\(score)")
        
        score = -5  // 实际值为 0
        print("score:\(score)")
    }
}
