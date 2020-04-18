//
//  BlankDetails.swift
//  courseWork
//
//  Created by alexander tsay on 16.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct BlankDetails: View {
    var name:String
    var lastName: String
    var job: String
    var describe: String
    var email: String
    var birthdate: String
    var weight: String
    var height: String
    var status: String
    var gender: String
    
    @State var showAlert = false
    
    @Binding var update: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Appeal details").font(.title).bold().padding()
            Spacer()
            Form {
                Text("First name: " + name).font(.headline)
                Text("Last name: " + lastName).font(.headline)
                Text("Email: " + email).font(.headline).multilineTextAlignment(.center)
                Text("Birth date: " + birthdate).font(.headline)
                Text("Job: " + job).font(.headline)
                Text("Weight: " + weight).font(.headline)
                Text("Height: " + height).font(.headline)
                Text("Gender: " + gender).font(.headline)
                Text("Marital status: " + status).font(.headline)
                Text("Description: " + describe).font(.headline).multilineTextAlignment(.center).lineLimit(10)
            }
            Spacer()
            Button(action:{
                self.showAlert = true
            }){
                Text("I will contact him").font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
                }.padding().alert(isPresented: $showAlert){ () -> Alert in
                        Alert(title: Text("Warning"), message: Text("Do you want to contact this patient?"), primaryButton: .default(Text("OK")){
                            
                            let url = URL(string: "http://localhost:8080/blank/update/" + self.email)!
                            var request = URLRequest(url: url)
                            request.httpMethod = "PUT"
                            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                            let str: String = "Bearer " + ViewRouter.creds.jwt
                            request.setValue(str, forHTTPHeaderField: "Authorization")
                            
                            let task = URLSession.shared.dataTask(with: request){
                                (data, response, error) in
                                guard let data = data else { return }
                                print(String(data:data, encoding: .utf8)!)
                                let httpResp = response as! HTTPURLResponse
                                DispatchQueue.main.async {
                                    if httpResp.statusCode == 200 {
                                        self.update.toggle()
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                            task.resume()
                            
                            }, secondaryButton: .cancel())
                }
        }
        
    }
}

struct BlankDetails_Previews: PreviewProvider {
    static var previews: some View {
        BlankDetails(name: "asd", lastName: "asd", job: "asd", describe: "asd", email: "asd", birthdate: "asd", weight: "asd", height: "asd", status: "asd", gender: "male", update: .constant(false))
    }
}
