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
    func testBaseOperation() {
        var data = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        
        var subject = PassthroughSubject<[Int], Never>()
        var cancellable = Set<AnyCancellable>()
    }
}
