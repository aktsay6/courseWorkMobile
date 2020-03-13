//
//  Message.swift
//  courseWork
//
//  Created by alexander tsay on 10.03.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation


class Message : Identifiable{
    var id = UUID()
    var content: String
    var sender: String
    
    init(){
        content = "aaa"
        sender = "aaa"
    }
    
    init(content:String, sender:String){
        self.content = content
        self.sender = sender
    }
}
