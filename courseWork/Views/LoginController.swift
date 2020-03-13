//
//  LoginController.swift
//  courseWork
//
//  Created by alexander tsay on 24.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation
import StompClientLib
import SwiftyJSON

class ChatController{
    
    init(){
        print("INITIALIZED")
        url = NSURL(string: "ws://localhost:8080/sock")!
        socket = StompClientLib()
        isConnected = false
    }
    
    var socket: StompClientLib
    var isConnected: Bool
    var url: NSURL
    
    func doSome() {
        var request = NSURLRequest(url: url as URL)
        request.setValue("Bearer " + ViewRouter.creds.jwt, forKey: "Authorization")
        socket.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    func disconnect(){
        let message = JSON(["messageType":"CHAT", "content":"asdasd", "sender":"user"])
        socket.sendMessage(message: message.rawString() ?? "def val", toDestination: "/app/chat/username/sendMessage", withHeaders: ["content-type" : "application/json"], withReceipt: nil)
//        socket.disconnect()
    }
}

extension ChatController: StompClientLibDelegate{
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print(jsonBody)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Client Disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Client Connected")
        socket.subscribe(destination: "/topic/username")
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

