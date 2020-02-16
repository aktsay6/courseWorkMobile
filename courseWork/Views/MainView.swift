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
            Rectangle().fill(Color.red).frame(width:200, height: 200)
            Text("Welcome").font(.largeTitle)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
