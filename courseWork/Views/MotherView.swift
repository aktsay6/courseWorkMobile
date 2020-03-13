//
//  MotherView.swift
//  courseWork
//
//  Created by alexander tsay on 12.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct MotherView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "login" {
                LoginView().transition(.scale)
            } else if viewRouter.currentPage == "main" {
                MainTabView()
                    .transition(.scale)
            } else if viewRouter.currentPage == "signup"{
                SignUpTabBarView()
                    .transition(.scale)
            }
            else if viewRouter.currentPage == "chat"{
                ChatView(chat: viewRouter.chat)
                    .transition(.scale)
            }
        }
    }
}

struct MotherView_Previews : PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
