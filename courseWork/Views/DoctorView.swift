//
//  DoctorView.swift
//  courseWork
//
//  Created by alexander tsay on 12.03.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct DoctorView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var chat : ChatController
    
    var body: some View {
        VStack{
            
            Text("Here you can help a patient. Just tap a button and you will be connected to chat")
                .fontWeight(.bold)
                .font(.custom("Helvetica Neue", size: 30))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            
            Button(action:{
                let url = URL(string: "http://localhost:8080/chat/doctorGetRoom")!
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                let str: String = "Bearer " + ViewRouter.creds.jwt
                request.setValue(str, forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request){
                    (data, response, error) in
                    let resp : String? = (String(data: data!, encoding: String.Encoding.utf8))
                    DispatchQueue.main.async {
                        if resp! != "none"{
                            print("ASDASD   " + resp!)
                            self.viewRouter.chat.room = resp!
                            self.viewRouter.chat.connect()
                            self.viewRouter.currentPage = "chat"
                        }else{
                            print(resp!)
                        }
                    }
                }
                task.resume()
            }){
                Text("Join chat").font(.title)
                    .foregroundColor(.white)
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0).lineLimit(2)
                }.padding()
        }
    }
}

struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorView(chat: ChatController()).environmentObject(ViewRouter())
    }
}
