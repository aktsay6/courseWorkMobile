//
//  Doctor.swift
//  courseWork
//
//  Created by alexander tsay on 18.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation


struct Doctor : Identifiable{
    var id = UUID()
    
    
    var username: String
    var name: String
    var lastName: String
    var job: String
    
    init(name:String, lastName:String, job:String, username:String) {
        self.job = job
        self.name = name
        self.lastName = lastName
        self.username = username
    }
}

#if DEBUG
let testData = [
    Doctor(name: "asd", lastName: "asdasd", job: "job", username: "username"),
    Doctor(name: "a", lastName: "aa", job: "aaa", username: "username"),
    Doctor(name: "end", lastName: "ender", job: "aaa", username: "username")
]
#endif

