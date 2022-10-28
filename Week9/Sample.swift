//
//  Sample.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/23.
//

import Foundation

class User {
    //매개변수 2개를 클로저로 넘겨줌
    private var listener: (String, String) -> Void = { oldName, newName in
        print("name changed: \(oldName) -> \(newName)")
    }
    
    //값이 변경되었을때 didSet을 실행하기 위한 매개변수 2개 필요(변경전,후)
    var name: String {
        didSet {
            listener(oldValue, name)
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func nameChanged(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

class User2 {
    private var listener: () -> Void = { }
    
    var name: String {
        didSet {
            listener() //listener 옵셔널 가능
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func nameChanged(completionHandler: @escaping () -> Void) {
        completionHandler()
        listener = completionHandler
    }
}

class User3 {
    private var listener: (String) -> Void = { _ in }
    
    var value: String {
        didSet {
            listener(value)
        }
    }
    
    init(_ value: String) { //외부매개변수 사용해서 함수호출할때 매개변수 표시 생략
        self.value = value
    }
    
    func bind(completionHandler: @escaping (String) -> Void) {
        completionHandler(value)
        listener = completionHandler
    }
}

class User4<T> { //제네릭호출할때 타입 결정됨
    private var listener: (T) -> Void = { _ in }
    
    var value: T {
        didSet {
            listener(value)
        }
    }
    
    init(_ value: T) { //외부매개변수 사용해서 함수호출할때 매개변수 표시 생략
        self.value = value
    }
    
    func bind(completionHandler: @escaping (T) -> Void) {
        completionHandler(value)
        listener = completionHandler
    }
}

