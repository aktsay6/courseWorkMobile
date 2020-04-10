//
//  ProfileView.swift
//  courseWork
//
//  Created by alexander tsay on 04.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    let gradient = LinearGradient(gradient: Gradient(colors: [Color(.darkGray), Color(.lightGray)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    @State var showActionSheet:Bool = false
    @State var showImagePicker:Bool = false
    @State var image:Image?
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Button(action:{
                        self.viewRouter.currentPage = "main"
                    }){
                        HStack {
                            Image(systemName: "arrowshape.turn.up.left")
                            Text("Back")
                        }
                    }.padding()
                    Spacer()
                }
                Spacer()
                VStack {
                    if (image != nil){
                        image!.resizable().frame(width: 80.0, height: 80.0, alignment: .center)
                            .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                CameraButtonView(showActionSheet: $showActionSheet)
                                    .offset(x:30, y: 25)
                        )
                    }
                    else{
                        Image(systemName: "person.circle").resizable().frame(width: 80.0, height: 80.0, alignment: .center)
                            .overlay(
                                CameraButtonView(showActionSheet: $showActionSheet)
                                    .offset(x:30, y: 25)
                        )
                    }
                    
                }.actionSheet(isPresented: $showActionSheet, content: {() -> ActionSheet in
                    ActionSheet(title: Text("Selected Image"), message: Text("Please select an image from the image gallery or use the camera"), buttons: [
                        ActionSheet.Button.default(Text("Camera"),action: {
                            
                        }),
                        ActionSheet.Button.default(Text("Photo Gallery"), action: {
                            self.showImagePicker.toggle()
                        }),
                        ActionSheet.Button.cancel()
                    ])
                })
                Text(ViewRouter.creds.userName).font(.largeTitle).padding()
                Text("Role: " + viewRouter.role.replacingOccurrences(of: "ROLE_", with: "").lowercased().capitalizingFirstLetter()).font(.title).padding()
                Spacer()
                Button(action:{
                    ViewRouter.creds.userName = ""
                    ViewRouter.creds.jwt = ""
                    self.viewRouter.currentPage = "login"
                }){
                    Text("LOGOUT").foregroundColor(Color.red).padding()
                }.background(RoundedRectangle(cornerRadius: 15)
                    .opacity(0.15))
                
            }.padding()
            if showImagePicker{
                ImagePicker(isVisible: $showImagePicker, image: $image)
            }
        }.onAppear(){
            self.image = ViewRouter.creds.image
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewRouter())
    }
}

extension String{
    func capitalizingFirstLetter() -> String{
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizingFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
