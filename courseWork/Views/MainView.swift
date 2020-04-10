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
            Text("Welcome").font(.largeTitle)
            Button(action: {
                self.viewRouter.chat.room = ViewRouter.creds.userName
                self.viewRouter.chat.connect()
                self.viewRouter.currentPage = "chat"
            }){
                Text("Connect to chat")
            }
            Button(action: {
                self.viewRouter.currentPage = "bot"
            }){
                Text("Check for heart diseases")
            }
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
