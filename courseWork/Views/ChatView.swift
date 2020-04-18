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
    
    @State var mes:String = ""
    
    @State var showAlert = false
    
    init(chat: ChatController){
        UITableView.appearance().separatorColor = .clear
        self.chat = chat
    }
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    self.showAlert = true
                }){
                    Image(systemName: "arrowshape.turn.up.left").padding(10)
                }
                .alert(isPresented: $showAlert){ () -> Alert in
                    Alert(title: Text("Warning"), message: Text("Do you want to end conversation?"), primaryButton: .default(Text("OK")){
                        self.chat.sendLeaveMessage(userName: ViewRouter.creds.userName, room: self.viewRouter.chat.room)
                        self.viewRouter.chat.disconnect()
                        self.viewRouter.currentPage = "main"
                        self.chat.msg.removeAll()
                        }, secondaryButton: .cancel())
                }
                Spacer()
                Text("Chat").font(.title).padding()
                Spacer()
            }.padding(7)
            List {
                ForEach(chat.msg){ message in
                    
                    if message.sender == ViewRouter.creds.userName {
                        MessageCell(message: message, selfMsg: true)
                    }else{
                        MessageCell(message: message, selfMsg: false)
                    }
                    
                }
            }
            HStack{
                TextField(" Enter your message", text: $mes)
                    .background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                    .cornerRadius(5)
                    .padding(3)
                Button(action: {
                    if(self.mes != ""){
                        if self.viewRouter.role == "ROLE_DOCTOR"{
                            self.viewRouter.chat.sendMessage(message: self.mes, userName: ViewRouter.creds.userName, room: self.viewRouter.chat.room)
                            self.mes = ""
                        }else{
                            self.viewRouter.chat.sendMessage(message: self.mes, userName: ViewRouter.creds.userName, room: ViewRouter.creds.userName)
                            self.mes = ""
                        }
                    }
                }){
                    Image(systemName: "paperplane")
                }.padding(10)
            }.padding(5)
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
            if message.type == MessageType.JOIN{
                Spacer()
                Text(message.sender + " joined chat").italic().padding(10)
                Spacer()
            }
            else if message.type == MessageType.LEAVE{
                Spacer()
                Text(message.sender + " left chat").italic().padding(10)
                Spacer()
            }
            else{
                if selfMsg{
                    Spacer()
                    Text(message.content)
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    Text(message.time)
                }
                else{
                    Text(message.time)
                    Text(message.content)
                        .padding(10)
                        .foregroundColor(Color.black)
                        .background(Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
            }
        }
    }
}

