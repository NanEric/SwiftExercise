//
//  TaskGroupQuizViewController.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/16.
//

import UIKit

//3. 🧩 结构化并发：扇出/扇入 (TaskGroup)
//您需要在一个 View Controller 的方法中，并发地从多个数据源获取数据，并组合成一个统一的模型，所有请求都必须成功。
//
//场景： 构建一个用户首页，需要同时获取用户的配置信息、最近订单列表和通知数量。
//
//练习要求：
//
//创建三个独立的 async 模拟函数：fetchConfig() -> String, fetchOrders() -> [String], fetchNotifications() -> Int。
//
//创建一个主 async 函数 func loadAllUserData() async throws -> (String, [String], Int)。
//
//在这个主函数中，使用 withThrowingTaskGroup 并发地执行这三个获取操作。
//
//使用 TaskGroup 的 next() 方法来等待并收集所有结果。

class TaskGroupQuizViewController: UIViewController {
    
    func fetchConfig() async throws -> String {
        do {
            try await Task.sleep(for: .seconds(4))
        } catch {
            return "fetch config error"
        }
        
        print("fetching config end")
        return "fetch config finished..."
    }
    
    func fetchOrders() async throws -> [String] {
        try await Task.sleep(for: .seconds(3))
        print("fetching Orders end")
        return ["111","112","113"]
    }
    
    func fetchNotifications() async -> Int {
        do {
            try await Task.sleep(for: .seconds(8))
        } catch {
            return 0
        }
        
        print("fetching Notifications end")
        return 8
    }
    
    func loadAllUsersData() async throws -> (String, [String], Int) {
        // Method 1
//        async let configStr = await fetchConfig()
//        async let ordersList = await fetchOrders()
//        async let notifications = await fetchNotifications()
//        print("waiting for all values....")
//        let result = try await (configStr,ordersList,notifications)
//        print("got all values....")
        
        enum FetchResult {
            case config(String)
            case orders([String])
            case notifications(Int)
        }
        
        // Method2
        return try await withThrowingTaskGroup(of: FetchResult.self) { group in
            group.addTask {
                return .config(try await self.fetchConfig())
            }
            
            group.addTask {
                return .orders(try await self.fetchOrders())
            }
            
            group.addTask {
                return .notifications(await self.fetchNotifications())
            }
            
            var config = ""
            var orders: [String] = []
            var notifications = 0
            
            print("waiting for all values....")
            for try await result in group {
                switch result {
                case .config(let c):
                    config = c
                case .orders(let o):
                    orders = o
                case .notifications(let n):
                    notifications = n
                }
            }
            
            print("got all values....")
            return (config, orders, notifications)
        }
    }
}
