//
//  SignUpController.swift
//  courseWork
//
//  Created by alexander tsay on 28.01.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import UIKit

class SignUpController {
    
    @IBAction func register(username: String, password: String) {
    
        
        let json: [String: Any] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        let url = URL(string: "http://localhost:8080/registration")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main){
            (response, data, error) in
            guard let data = data else { return }
            print(String(data:data, encoding: .utf8)!)
        }
    }
}
