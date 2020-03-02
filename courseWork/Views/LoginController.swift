//
//  LoginController.swift
//  courseWork
//
//  Created by alexander tsay on 24.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation
import StompClientLib

class LoginController{
    
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
        socket.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    func disconnect(){
        socket.disconnect()
    }
}

extension LoginController: StompClientLibDelegate{
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print(jsonBody)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Client Disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Client Connected")
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

