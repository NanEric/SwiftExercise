//
//  PublishedFake.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/11.
//

import Foundation
import Combine

//@PublishedOnce：模仿 @Published，但仅在 “首次赋值” 时发送通知（后续赋值不触发）。要求：
//基于 Combine 的 PassthroughSubject；
//内部维护 “是否已赋值” 的标记；
//支持 objectWillChange 或自定义 Publisher。

@propertyWrapper
class PublishedOnce<T> {
    private var publisher = PassthroughSubject<T, Never>()
    private var hasAssigned = false
    private var value: T?

    var wrappedValue: T {
        set {
            guard !hasAssigned else {
                return
            }

            hasAssigned = true
            value = newValue
            publisher.send(newValue)
            publisher.send(completion: .finished)
        }
        
        get {
            guard let value = value else {
                fatalError("PublishedOnce has not been assigned")
            }
            return value
        }
    }

    var projectedValue: AnyPublisher<T, Never> {
        return publisher.eraseToAnyPublisher()
    }

    init() {
        
    }

    init(wrappedValue: T) {
        self.value = wrappedValue
//        self.hasAssigned = true
    } 
}


class ViewModel/*: ObservableObject*/ {
    @PublishedOnce var name: String = "Initial"
    var cancelable = Set<AnyCancellable>()
    
    func updateName() {
        name = "New Name" // 只有第一次调用会触发通知
        name = "Another Name" // 不会触发通知
    }

    func subscribe() {
        $name.sink { value in
            print("Name changed to: \(value)")
        }
        .store(in: &cancelable)

    }
}

