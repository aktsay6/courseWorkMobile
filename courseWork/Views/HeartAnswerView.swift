//
//  HeartAnswerView.swift
//  courseWork
//
//  Created by alexander tsay on 04.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct HeartAnswerView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Spacer()
            Text("In ten years you may have heart diseases").font(.largeTitle)
            Spacer()
            Button(action:{
                self.viewRouter.currentPage = "main"
            }){
                Text("Back")
            }
            
        }
    }
    
}

struct HeartAnswerViewFalse: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Spacer()
            Text("In ten years you may NOT have heart diseases").font(.largeTitle)
            Spacer()
            Button(action:{
                self.viewRouter.currentPage = "main"
            }){
                Text("Back")
            }
            
        }
    }
    
}

struct HeartAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        HeartAnswerView().environmentObject(ViewRouter())
    }
}
