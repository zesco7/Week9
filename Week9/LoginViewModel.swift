//
//  LoginViewModel.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/23.
//

import Foundation

class LoginViewModel {
    var email: Observable<String> = Observable("") //반응형으로 타입설정
    var password: Observable<String> = Observable("") //반응형으로 타입설정
    var name: Observable<String> = Observable("") //반응형으로 타입설정
    var isValid: Observable<Bool> = Observable(false) //반응형으로 타입설정
    
    func checkValidation() {
        if email.value.count >= 6 && password.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(name.value, forKey: "name")
        completion()
    }
}
