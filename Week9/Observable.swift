//
//  Observable.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/23.
//

import Foundation

class Observable<T> { //양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    //bind가 가진 클로저가 listener에 저장되었기 때문에 didSet에 의해 value가 바뀔때마다 listener도 실행된다. 그렇기 때문에 값이 변경될때마다 연산처리 할 수 있음.
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure //bind의 클로저와 타입이 같기 때문에 클로저 대입 가능((T) -> Void)
    }
}
