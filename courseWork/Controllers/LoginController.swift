//
//  LoginController.swift
//  courseWork
//
//  Created by alexander tsay on 28.01.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//
import UIKit

class LoginController {
    
    
    func login(username: String, password: String) {

        
        let json: [String: Any] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        let url = URL(string: "http://localhost:8080/authenticate")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData){
            (data, response, error) in

            guard let data = data else { return }
            print(String(data:data, encoding: .utf8)!)
            DispatchQueue.main.async {
                SignUpView()
            }
        }
        task.resume()
        
    }
}
