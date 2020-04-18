//
//  MainTabView.swift
//  courseWork
//
//  Created by alexander tsay on 18.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            TabView {
                MainView().tabItem{
                    Text("Main")
                }
                
                if viewRouter.role == "ROLE_ADMIN"{
                    AdminView().tabItem{
                        Text("Doctor list")
                    }
                }else if (viewRouter.role == "ROLE_DOCTOR"){
                    DoctorView(chat: viewRouter.chat).tabItem {
                        Text("Help patient")
                    }
                    CheckBlanksView().tabItem{
                        Text("Check blanks")
                    }
                }
                
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView().environmentObject(ViewRouter())
    }
}
