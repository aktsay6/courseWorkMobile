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
    var type: String
    
    init(){
        content = "aaa"
        sender = "aaa"
        type = "send"
    }
    
    init(content:String, sender:String, type:String){
        self.content = content
        self.sender = sender
        self.type = type
    }
}
