//
//  ViewController.swift
//  SwiftExercise
//
//  Created by eric on 2025/12/10.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    
    var vm: FormAuthViewModel = FormAuthViewModel()
    var cancellables = Set<AnyCancellable>()
    
    var btn: UIButton = UIButton(type: .roundedRect)

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

//        var combineTest = MyCombineTest()
        
//        combineTest.testBaseOperation()
        

        ////////////////////// Form Auth ////////////////////
        #if COMMENT
        let textfieldName: UITextField = UITextField()
        textfieldName.bounds = CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: 300, height: 100))
        textfieldName.center = view.center
        textfieldName.layer.borderColor = UIColor.blue.cgColor
        textfieldName.layer.borderWidth = 1
        view.addSubview(textfieldName)
        
        textfieldName.text = vm.name
        textfieldName.keyboardType = .default
        textfieldName.delegate = self
        
        vm.$name.sink { [weak self] newValue in
            print("newValue is \(newValue)")
            if textfieldName.text != newValue {
                textfieldName.text = newValue
            }
            print("vm newValue is \(self?.vm.name)")
        }
        .store(in: &cancellables)
        
        
        btn.setTitle("change value", for: UIControl.State.normal)
        view.addSubview(btn)
        btn.frame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 100, height: 50))
        btn.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        #endif
        ///////////////// Auth end //////////////////////////////
        ///
    
        var taskGroupQuizVC = TaskGroupQuizViewController()
        
        Task {
            let result = try await taskGroupQuizVC.loadAllUsersData()
            print("\(result)")
        }
        
        
        
    }

    @objc func changeValue() {
        vm.changeNameInModelData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        vm.name = textField.text ?? "111"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            vm.name = text
        }
    }
}


class FormAuthViewModel: ObservableObject {
    @Published var name: String = ""
    
    func changeNameInModelData() {
        name = "aaa"
    }
}
