//
//  LocalizableViewController.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/27.
//

import UIKit
import CoreLocation
import MessageUI

/*
 -.리뷰남기기: SKStoreReviewController(1년 3회 정도 가능)
 -.문의남기기: MessageUI(1년 3번 정도 표시) //메일만 문의가능, 디바이스에서만 가능(시뮬레이터X), 아이폰 메일계정 등록헤야 가능
 */

class LocalizableViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Localizable.strings파일에 정의한 내용 표시하려면 NSLocalizedString사용(comment는 객체설명용으로 화면에 보이는 부분 아님)
        //아이폰 언어설정에 따라서 Localizable.strings파일에 정의한 내용 표시됨
        navigationItem.title = "navigation_title".localized
        
        //myLabel.text = String(format: NSLocalizedString("number_test", comment: ""), 123)
        myLabel.text = "introduce".localized(with: "호날두")
        
        searchBar.placeholder = "search_placeholder".localized
        
        inputTextField.placeholder = "main_age_placeholder".localized
        
        sampleButton.setTitle("common_cancel".localized, for: .normal)
        
        //CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            //아이폰 메일계정 있으면 문의 가능
            let mail = MFMailComposeViewController()
            mail.setCcRecipients(["jack@jack.com"]) //메일 수신 주소 가능
            mail.setSubject("고래밥 다이어리 문의사항 -") //메일 제목 설정 가능
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
        } else {
            //alert로 내용 안내: 메일 등록하거나 jack@jack.com으로 문의주세요
            print("Alert")
        }
    }
    
    //메일 송신 여부 확인 가능
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print(#function)
        case .saved: //임시저장
            print(#function)
        case .sent:
            print(#function)
        case .failed:
            print(#function)
        }
        controller.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
    }
    
}

extension String {
    var localized: String { //연산프로퍼티
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String { //매개변수 타입 많을 때 제네릭 사용하면 간소화 가능
        return String(format: self.localized, with)
    }
}
