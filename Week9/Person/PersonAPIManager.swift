//
//  PersonAPIManager.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/16.
//
/*
import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completion: @escaping (Person?, APIError) -> Void) {
        
        //url구조를 나눠볼 수도 있음
        let url = URL(string: "https://www.themoviedb.org/3/search/person?api_key=9a2ad201c752108bc7ef6648ba28b7ef&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "9a2ad201c752108bc7ef6648ba28b7ef"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                    let result = try JSONDecoder().decode(Person.self, from: data!)
                    completion(result, nil)
                } catch {
                    print("ERROR")
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
*/
