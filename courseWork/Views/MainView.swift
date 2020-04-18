//
//  MainView.swift
//  courseWork
//
//  Created by alexander tsay on 12.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        
        VStack {
            HStack{
                Button(action:{
                    self.viewRouter.currentPage = "profile"
                }){
                    HStack {
                        Image(systemName: "person.circle").foregroundColor(Color.black)
                        Text("Profile").font(.headline).foregroundColor(.black)
                    }.padding()
                }.padding()
                Spacer()
            }
            Spacer()
            Button(action: {
                self.viewRouter.chat.room = ViewRouter.creds.userName
                self.viewRouter.chat.connect()
                self.viewRouter.currentPage = "chat"
            }){
                Image(systemName: "bubble.left.and.bubble.right")
                .font(.title)
                Text("Connect to chat")
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.green), Color(.red)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            Button(action: {
                self.viewRouter.currentPage = "bot"
            }){
                Image(systemName: "heart").font(.title)
                Text("Check for heart diseases")
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.green), Color(.red)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            
            Button(action: {
                self.viewRouter.currentPage = "blank"
            }){
                Image(systemName: "square.and.pencil").font(.title)
                Text("Fill in the blank")
            }.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.green), Color(.red)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
