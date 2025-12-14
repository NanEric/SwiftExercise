//
//  PublisherExercise.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/12.
//

import Foundation
import Combine

//Publisher 基础操作
//数据流转换与过滤：基于 PassthroughSubject<Int, Never>，实现以下逻辑：
//过滤掉偶数；
//将奇数乘以 10；
//防抖（debounce）0.3 秒；
//只取前 5 个值；
//订阅并打印结果。

class MyCombineTest {
    var subject = PassthroughSubject<Int, Never>()
    var cancellable = Set<AnyCancellable>()
    private var data = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    func testBaseOperation() {
        
//        // 创建定时器发布器
//            let timer = Timer.publish(every: 0.5, on: .main, in: .common)
//                .autoconnect()
//                .zip(data.publisher) { _, value in
//                    print("发送原始值: \(value)")
//                    return value }  // 将定时器与数据源结合
//                .sink(
//                    receiveCompletion: { _ in
//                                        print("数据发送完成")
//                                    },
//                                    receiveValue: { [weak self] value in
//                                        self?.subject.send(value)
//                                    }
//                )
//            
//            // 存储定时器
//            cancellable.insert(AnyCancellable { timer.cancel() })
        
        subject.filter {
            $0 % 2 != 0
        }
        .map {
            $0 * 10
        }
//        .debounce(for: .seconds(0.3), scheduler: RunLoop.main)  // 如果这里打开，0.3s内过来的数据，都不会处理，会打印异常。
        .prefix(5)
        .sink { completion in
            switch completion {
            case .finished:
                print("数据流完成")
            case .failure(let error):
                print("发生错误: \(error)")
            }
        } receiveValue: { value in
            print("接收到的值: \(value)")
        }
        .store(in: &cancellable)


        data.forEach { value in
            subject.send(value)
        }
        
        // 发送完成信号
        subject.send(completion: .finished)
    }
}
