//
//  ChatView.swift
//  courseWork
//
//  Created by alexander tsay on 10.03.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var chat : ChatController
    
    init(chat: ChatController){
        UITableView.appearance().separatorColor = .clear
        self.chat = chat
    }
    
    var body: some View {
        VStack{
            Text("CHAT")
            List {
                ForEach(chat.msg){ message in
                    if message.sender == ViewRouter.creds.userName {
                        MessageCell(message: message, selfMsg: true)
                    }else{
                        MessageCell(message: message, selfMsg: false)
                    }
                }
            }
            Button(action: {
                self.viewRouter.chat.sendMessage(message: "asdasd", userName: ViewRouter.creds.userName)
            }){
                Text("Send")
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: ChatController()).environmentObject(ViewRouter())
    }
}

struct MessageCell: View{
    let message: Message
    var selfMsg = false
    var body: some View{
        HStack{
            if selfMsg{
                Spacer()
                Text(message.content)
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            else{
                Text(message.content)
                    .padding(10)
                    .foregroundColor(Color.black)
                    .background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                    .cornerRadius(10)
            }
        }
    }
}
