//
//  Blank.swift
//  courseWork
//
//  Created by alexander tsay on 16.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation

struct Blank: Identifiable{
    var id = UUID()
    
    
    var name: String
    var lastName: String
    var job: String
    var describe: String
    var email: String
    var birthdate: String
    var weight: String
    var height: String
    var status: String
    var appealDate: String
    var gender: String
    
    init(name:String, lastName:String, job:String, describe:String, email:String, birthdate: String, weight: String, height: String, status:String, appealDate: String, gender:String) {
        self.job = job
        self.name = name
        self.lastName = lastName
        self.describe = describe
        self.email = email
        self.birthdate = birthdate
        self.weight = weight
        self.height = height
        self.status = status
        self.appealDate = appealDate
        self.gender = gender
    }
}
