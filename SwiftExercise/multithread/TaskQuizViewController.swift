//
//  TaskQuizViewController.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/16.
//

import Foundation
import UIKit


//2. ⚡️ 非结构化并发与取消 (Task)
//在 UIKit 中，我们经常需要启动一个后台任务，但不需要立即等待其结果，并且需要手动管理其生命周期，防止 View Controller 销毁后任务仍在运行。
//
//场景： 在一个 UIViewController 中，您需要在视图加载后启动一个耗时的日志上传任务，并在 View Controller 销毁时确保该任务被取消。
//
//练习要求：
//
//定义一个 UIViewController 子类。
//
//在其中定义一个可选的 Task<Void, Never> 属性来存储后台任务。
//
//在 viewDidLoad() 中，使用 Task { ... } 启动一个任务，并在内部模拟一个耗时操作，同时使用 Task.checkCancellation() 检查取消状态。
//
//在 deinit 方法中，实现安全取消任务的逻辑。

class TaskQuizViewController: UIViewController {
    var uploadTask: Task<Void, Never>?
    
    init(uploadTask: Task<Void, Never>? = nil) {
        self.uploadTask = uploadTask
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        uploadTask?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            //1. check 取消的task
            try Task.checkCancellation()
            
            //2. 模拟延迟
            try await Task.sleep(for: .seconds(5))
            
            print("log upload ......")
            
        }
    }
}
