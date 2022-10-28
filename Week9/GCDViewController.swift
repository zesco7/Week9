//
//  GCDViewController.swift
//  Week9
//
//  Created by Mac Pro 15 on 2022/10/26.
//

import UIKit

class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var imageFIrst: UIImageView!
    @IBOutlet weak var imageSecond: UIImageView!
    @IBOutlet weak var imageThird: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //serialSync 사용 안함:
    @IBAction func serialSync(_ sender: UIButton) {
        print("START")
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        //메인스레드에서 메인큐에 내린 작업명령이 완료 될때까지 메인스레드는 block상태인데 메인큐는 메인스레드에 작업을 할당하여 진행해야하기 때문에 deadlock발생해서 에러남
        //        DispatchQueue.main.sync {
        //            for i in 101...200 {
        //                print(i, terminator: " ")
        //            }
        //        }
        
        print("END")
    }
    
    //serialAsync: UI다룰 때 사용
    @IBAction func serialAsync(_ sender: UIButton) {
        print("START")
        //작업큐에 보내고 다음 작업 먼저 진행하기 때문에 101~200 ->1~100순으로 프린트 실행(같은 메인스레드에서 작업하기 때문에 숫자가 섞여나올수없음)
        DispatchQueue.main.async { //queue로 task1개 보냄
            for i in 1...10 {
                print(i, terminator: " ")
            }
        }
        
        for i in 1...100 { //queue로 task1개 보냄
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //globalSync 사용 안함: 다른 스레드에 작업명령해도 메인스레드에서 작업하기 때문
    @IBAction func globalSync(_ sender: UIButton) {
        print("START")
        DispatchQueue.global().sync { //queue로 task1를 다른 스레드에서 작업해도 작업속도는 동일하기 때문에 애플이 자체적으로 메인스레드에서 작업 시킴(그래서 1~100->101~200순 프린트 실행)
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //globalAsync: 네트워크통신할때 주로 사용
    @IBAction func globalAsync(_ sender: UIButton) {
        print("START\(Thread.isMainThread)", terminator: " ")
        
        //        DispatchQueue.global().async {
        //            for i in 1...100 {
        //                print(i, terminator: " ")
        //            }
        //        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END\(Thread.isMainThread)")
    }
    
    //QoS: 중요한 작업은 빨리 처리하고 싶을 때 사용
    @IBAction func qos(_ sender: UIButton) {
        
        //특정 업무에 대한 네이밍을 통해 별도 관리할 수 있음
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        
        customQueue.async {
            print("START")
        }
        
        //최후순위
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        //최우선순위로 작업: 더 많은 스레드에 작업이 분배되어 빨리 처리하는 구조
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        //2순위
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        //ex. 별개API 3개 사용할때 갱신 방법: 1. 3개 전부 통신종료 때 갱신 2. 1개 종료마다 갱신
        //3개 전부 통신 종료때 갱신하기 위해 그룹핑 사용해서 통신종료 시점을 확인하고 갱신한다.
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        //main queue에 명령실행 종료 신호 보내기
        group.notify(queue: .main) {
            print("끝")
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star")) //데이터수신 실패시 별이미지
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image) //데이터수신 성공시 받은 이미지 데이터
            
        }.resume()
    }
    
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
        //        request(url: url1) { image in
        //            print("1")
        //            self.request(url: self.url2) { image in
        //                print("2")
        //                self.request(url: self.url3) { image in
        //                    print("3")
        //                    print("end. 갱신")
        //                }
        //            }
        //        }
        
        
        //request메서드도 비동기로 처리하기 때문에 비동기처리 안에 비동기처리 형태가 되어서 비동기로 작동하지 않게 됨.
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("1")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        
        //main queue에 명령실행 종료 신호 보내기
        group.notify(queue: .main) {
            print("끝")
        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        
        //enter/leave 비동기통신 탈출 취소를 막아줌(마지막 통신 끝나면 동시에 갱신)
        let group = DispatchGroup()
        
        var imageList : [UIImage] = []
        
        group.enter() //네트워크통신 시작하는 시점에 enter
        request(url: url1) { image in
            imageList.append(image!)
            print("1")
            group.leave() //네트워크통신 끝나는 시점에 leave
        }
        
        group.enter()
        request(url: url2) { image in
            imageList.append(image!)
            print("2")
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            print("3")
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.imageFIrst.image = imageList[0]
            self.imageSecond.image = imageList[1]
            self.imageThird.image = imageList[2]
            print("끝. 확인.")
        }
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        //서로 다른 쓰레드에서 같은 변수에 접근할 때 문제가 생길 수 있음
        let group = DispatchGroup()
        var nickname = "SeSAC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("first: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("second: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
}
