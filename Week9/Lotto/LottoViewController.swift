//
//  LottoViewController.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/23.
//

import UIKit

/*
 1. 로또API 호출
 2. json+dateformatter
 3. 화면 표시
 */
class LottoViewController: UIViewController {

    @IBOutlet weak var lottoNum1: UILabel!
    @IBOutlet weak var lottoNum2: UILabel!
    @IBOutlet weak var lottoNum3: UILabel!
    @IBOutlet weak var lottoNum4: UILabel!
    @IBOutlet weak var lottoNum5: UILabel!
    @IBOutlet weak var lottoNum6: UILabel!
    @IBOutlet weak var lottoBonus: UILabel!
    @IBOutlet weak var lottoDate: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
       bindData()

    }
    
    func bindData() {
        viewModel.number1.bind { value in
            self.lottoNum1.text = "\(value)"
        }
        
        viewModel.number2.bind { value in
            self.lottoNum2.text = "\(value)"
        }
        
        viewModel.number3.bind { value in
            self.lottoNum3.text = "\(value)"
        }
        
        viewModel.number4.bind { value in
            self.lottoNum4.text = "\(value)"
        }
        
        viewModel.number5.bind { value in
            self.lottoNum5.text = "\(value)"
        }
        viewModel.number6.bind { value in
            self.lottoNum6.text = "\(value)"
        }
        
        viewModel.bonus.bind { value in
            self.lottoBonus.text = "\(value)"
        }
        
        viewModel.lottoMoney.bind { value in
            self.lottoDate.text = value
        }
    }

}
