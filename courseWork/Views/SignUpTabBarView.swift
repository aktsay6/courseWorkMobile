//
//  SignUpTabBarView.swift
//  courseWork
//
//  Created by alexander tsay on 11.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct SignUpTabBarView: View {
    var body: some View {
        TabView{
            SignUpView().tabItem {
                Text("User")
            }
            
            DoctorSignUpView().tabItem{
                Text("Doctor")
                
            }
        }
    }
}

struct SignUpTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTabBarView()
    }
}
