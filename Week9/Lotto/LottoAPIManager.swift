//
//  LottoAPIManager.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/16.
//

import Foundation

//shared: 단순한 요청에 사용. 커스텀/백그라운드 전송 못함. 응답을 클로저로 받음.
//init(configuration: .default): shared와 설정 유사함. 커스텀 가능(사용자의 셀룰러 연결 여부확인, 타임아웃간격 등). 응답을 클로저로 받음

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    static func requestLotto(drwNo: Int, completion: @escaping(Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
//        let dataForHeader = URLRequest(url: url)
//        a.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>) //헤더사용할때
        
        //url을 요청
        //메인쓰레드가 아니라 글로벌로 동작함.
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data)
            print(String(data: data!, encoding: .utf8))
            print(response)
            print(error)
            
            DispatchQueue.main.async {
                //error가 없는 경우만 통신 진행
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard data == data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                //클로저로 받은 response의 statusCode체크하기 위해 HTTPURLResponse로 타입캐스팅
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                //클로저로 받은 string타입 로또데이터 data를 구조체Lotto에 디코딩한다.(애초에 json 데이터타입을 받아올거라 데이터타입변환 필요없음.)
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data!)
                    completion(result, nil)
                } catch {
                    print("ERROR")
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}

