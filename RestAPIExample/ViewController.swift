//
//  ViewController.swift
//  RestAPIExample
//
//  Created by BridgeLabz on 10/07/19.
//  Copyright © 2019 BridgeLabz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // userLogInCredentials
    let userLoginCredentials = ["email": "ajayverma123@gmail.com"
        , "password" : "ajay123"]
    
    // userSignInCredentials
    let user = [
        "firstName": "ajay",
        "lastName": "verma",
        "phoneNumber": "1234567890",
        "imageUrl": "none",
        "role": "student",
        "service": "advance",
        "createdDate": "2019-07-10T07:47:25.802Z",
        "modifiedDate": "2019-07-10T07:47:25.802Z",
        "addresses": [
            ""
        ],
        "realm": "none",
        "username": "ajay",
        "password": "ajay123",
        "email": "ajayverma123@gmail.com",
        "emailVerified": true,
        "id": "none"
        ] as [String : Any]
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onGetPressed(_ sender: UIButton) {
        let url = URL(string: "http://34.213.106.173/api/user")
        
        session.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("data is nil")
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonData)
            } catch let error {
                print(error.localizedDescription)
            }
            
            print(data)
            
            guard let response = response else {
                print("response is nil")
                return
            }
            
            print(response)
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func onLogInPressed(_ sender: UIButton) {
        /*  login credentials are sent to this api request in header body
         */
        
        let url = URL(string: "http://34.213.106.173/api/user/login")
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = HttpMethods.Post.rawValue
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: userLoginCredentials, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        
        session.dataTask(with: urlRequest) {(data, urlResponse, error) in
            guard let data = data else {
                print("data is nil")
                return
            }
            
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
            print(jsonData ?? "jsonData is nil")
            print("data : \(data)")
            
            guard let response = urlResponse else {
                print("response is nil")
                return
            }
            print("response : \(response)")
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func onLogoutPressed(_ sender: UIButton) {
        let url = URL(string: "http://34.213.106.173/api/user/logout")
        
        // last access token of loopback api.. (we can get the accesstoken after signing up)
        let accessToken = "QkVqmHijvwNzscKRgWiujIbUsaXH1COC7CeM4DA3SOdXcam6X2w0ZHtvmFM30Yuo"
        
        let httpHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": accessToken
        ]
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = HttpMethods.Post.rawValue
        urlRequest.allHTTPHeaderFields = httpHeaders
        
        session.dataTask(with: urlRequest) {(data, urlResponse, error) in
            guard let data = data else {
                print("data is nil")
                return
            }
            
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
            print(jsonData ?? "jsonData is nil")
            print("data : \(data)")
            
            guard let response = urlResponse else {
                print("response is nil")
                return
            }
            print("response : \(response)")
            
            if error != nil {
                print(error!.localizedDescription)
            }
            }.resume()
    }
}

// Enum for HTTP Methods
enum HttpMethods : String {
    case Get = "GET"
    case Post = "POST"
    case Put = "PUT"
    case Delete = "Delete"
}
