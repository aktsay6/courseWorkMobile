//
//  BlankView.swift
//  courseWork
//
//  Created by alexander tsay on 16.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct BlankView: View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    @State var name: String = "Anton"
    @State var lastname: String = "Ivanov"
    @State var job: String = "Surgeon"
    @State var birthDate = Date()
    @State var email: String = "some@yandex.ru"
    @State var height: String = "190"
    @State var weight: String = "80"
    @State var mar_status: String = "asd"
    @State var describe: String = "ssssss"
    @State var gender: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.viewRouter.currentPage = "main"
                }){
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("Back")
                }.padding()
                Spacer()
                Text("Medical Blank").font(.largeTitle).bold()
                Spacer()
            }
            Form{
                Group{
                    TextField("Enter your firstname", text: $name)
                    TextField("Enter your lastname", text: $lastname)
                    TextField("Enter your job", text: $job)
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date){
                        Text("Enter your birthDate")
                    }
                    TextField("Enter your email", text: $email)
                    TextField("Enter your height", text: $height)
                    TextField("Enter your weight", text: $weight)
                    TextField("Enter your gender", text: $gender)
                    TextField("Enter your marital status", text: $mar_status)
                    TextView(placeholderText: "Describe your problem (max. 255 symbols)", text: $describe).frame(numLines: 4)
                }
                
            }
            Button(action:{
                let date = Date()
                
                let json: [String: Any] = ["name": self.name, "lastname": self.lastname, "job": self.job, "email": self.email, "height": self.height, "weight": self.weight, "status": self.mar_status, "problem": self.describe, "birth": self.birthDate.description, "username": ViewRouter.creds.userName, "gender" : self.gender, "appeal": date.description]
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                let url = URL(string: "http://localhost:8080/blank/add")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                let str: String = "Bearer " + ViewRouter.creds.jwt
                request.setValue(str, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.uploadTask(with: request, from: jsonData){
                    (data, response, error) in
                    let httpResp = response as! HTTPURLResponse // Catch exception when server doesnt work
                    DispatchQueue.main.async {
                        if httpResp.statusCode == 200 {
                            print("Success")
                            self.viewRouter.currentPage = "main"
                        }
                        if httpResp.statusCode == 403{
                            print("No such user")
                        }
                    }
                }.resume()
            }){
                Text("Send").font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
        }
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView().environmentObject(ViewRouter())
    }
}
