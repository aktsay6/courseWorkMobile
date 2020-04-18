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
    var type: MessageType
    var time: String
    
    init(){
        content = "aaa"
        sender = "aaa"
        type = MessageType.CHAT
        time = "123"
    }
    
    init(content:String, sender:String, type:MessageType, time:String){
        self.content = content
        self.sender = sender
        self.type = type
        self.time = time
    }
}

enum MessageType{
    case JOIN
    case LEAVE
    case CHAT
}
