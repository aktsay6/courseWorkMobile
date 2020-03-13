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
            Button(action:{
                let url = URL(string: "http://localhost:8080/chat/doctorGetRoom")!
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                let str: String = "Bearer " + ViewRouter.creds.jwt
                request.setValue(str, forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request){
                    (data, response, error) in
                    let httpResp = response as! HTTPURLResponse
                    var a = (String(data: data!, encoding: String.Encoding.utf8))
                    print(a)
                    DispatchQueue.main.async {
                        
                    }
                }
                task.resume()
            }){
                Text("Help patient!").font(.title)
            }
        }
    }
}

struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorView(chat: ChatController()).environmentObject(ViewRouter())
    }
}
