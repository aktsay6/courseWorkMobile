//
//  ChatController.swift
//  courseWork
//
//  Created by alexander tsay on 24.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation
import StompClientLib
import SwiftyJSON

class ChatController : ObservableObject{
    
    @Published var msg = [Message]()
    var room : String
    
    init(){
        print("INITIALIZED")
        url = NSURL(string: "ws://localhost:8080/sock")!
        socket = StompClientLib()
        room = ""
    }
    
    var socket: StompClientLib
    var url: NSURL
    
    func connect() {
        socket.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    func disconnect(){
        socket.disconnect()
    }
    func sendMessage(message : String, userName: String, room: String){
        let message = JSON(["messageType":"CHAT", "content":message, "sender": userName])
        socket.sendMessage(message: message.rawString() ?? "def val", toDestination: "/app/chat/" + room + "/sendMessage", withHeaders: ["content-type" : "application/json"], withReceipt: nil)
    }
    
}

extension ChatController: StompClientLibDelegate{
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        let json = JSON(jsonBody as Any)
        let sender = json["sender"].stringValue
        let content = json["content"].stringValue
        let type = json["type"].stringValue
        let message = Message(content: content, sender: sender, type: type)
        msg.append(message)
        print(json)
        print(msg.count)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Client Disconnected")
        socket.unsubscribe(destination: "/topic/" + room)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Client Connected")
        socket.subscribe(destination: "/topic/" + room)
        let message = JSON(["messageType":"JOIN", "content":"null", "sender": ViewRouter.creds.userName])
        socket.sendMessage(message: message.rawString() ?? "def val", toDestination: "/app/chat/" + room + "/addUser", withHeaders: ["content-type" : "application/json"], withReceipt: nil)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Server send receipt")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("ERROR")
    }
    
    func serverDidSendPing() {
        print("pong")
    }
    
    
}

