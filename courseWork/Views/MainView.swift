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
            Text("Welcome").font(.largeTitle)
            Button(action: {
                self.viewRouter.chat.room = ViewRouter.creds.userName
                self.viewRouter.chat.connect()
                self.viewRouter.currentPage = "chat"
            }){
                Text("Connect")
            }
            Button(action: {
                self.viewRouter.chat.disconnect()
            }){
                Text("Disconnect")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
