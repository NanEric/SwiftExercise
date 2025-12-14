//
//  ViewController.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/10.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        var test: TestWrapper = TestWrapper()

//        TestWrapper.testUserDefault()
  
//        TestWrapper.testClamped()
        
//        TestLevelUp.testValidated()
        
        
//        let viewModel = ViewModel()
//        viewModel.subscribe()
//        viewModel.updateName()

        var combineTest = MyCombineTest()
        
        combineTest.testBaseOperation()
        
        // 保持程序运行
        RunLoop.main.run()

    }


}

