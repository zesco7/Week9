//
//  LoginViewController.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargetExcuted()
        
        //bind실행 하면 (T) -> Void 타입 클로저 사용할 수 있다. string타입 인자를 nameTextField.text에 저장는 용도로 사용
        viewModel.name.bind { text in
            self.nameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .red
        }
        
    }
    
    func addTargetExcuted() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func nameTextFieldChanged() {
        viewModel.name.value = nameTextField.text! //nameTextField내용으로 뷰모델 name프로퍼티를 초기화
        viewModel.checkValidation()
    }
    
    @objc func passwordTextFieldChanged() {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func emailTextFieldChanged() {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func loginButtonClicked() {
        viewModel.signIn {
            print(#function)
        }
    }
}
