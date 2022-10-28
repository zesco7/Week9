//
//  ViewController.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/16.
//
/*
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lottoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var num3 = Observable(10)
        var num4 = Observable(5)
        LottoAPIManager.requestLotto(drwNo: 1011) { lotto, error in
            guard let lotto = lotto else {
                return
            }
            
            //LottoAPIManager에서 DispatchQueue.main.async처리해주면 viewDidLoad에서 생략 가능
            self.lottoLabel.text = lotto.drwNoDate
            
            //DispatchQueue.main.async { self.lottoLabel.text = lotto.drwNoDate }
        }
        
        PersonAPIManager.requestPerson(query: "kim") { person, error in //한글로 통신요청하면 에러
            guard let person = person else {
                return
            }
            dump(person)
        }
    }


}

*/
