//
//  DoctorDetail.swift
//  courseWork
//
//  Created by alexander tsay on 18.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct DoctorDetail: View {
    var username:String
    var name:String
    var lastName: String
    var job: String
    var describe: String
    var email: String
    var birthdate: String
    
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var reason:String = ""
    @State var show = false
    
    @Binding var update: Bool
    
    var body: some View {
        VStack {
            Form{
                Text("Doctor details").font(.title).bold().padding().frame(minWidth: 0, idealWidth: 50, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                Group {
                    Text("Username: " + username).font(.headline)
                    Text("First name: " + name).font(.headline)
                    Text("Last name: " + lastName).font(.headline)
                    Text("Email: " + email).font(.headline).multilineTextAlignment(.center)
                    Text("Birth date: " + birthdate).font(.headline)
                    Text("Job: " + job).font(.headline)
                    Text("Description: " + describe).font(.headline).multilineTextAlignment(.center).lineLimit(10)
                }.padding()
                if self.show{
                    Text("Input reason first").foregroundColor(Color.red).padding()
                }
                Group{
                    Button(action:{
                        self.showAlert = true
                    }){
                        ApproveButtonView()
                    }.frame(minWidth: 0, idealWidth: 50, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                        .alert(isPresented: $showAlert){ () -> Alert in
                            Alert(title: Text("Warning"), message: Text("Do you want to approve this doctor?"), primaryButton: .default(Text("OK")){
                                let url = URL(string: "http://localhost:8080/admin/update/" + self.username)!
                                var request = URLRequest(url: url)
                                let json: [String: Any] = ["email": self.email, "reason": "Your account had been approved!"]
                                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                                request.httpMethod = "PUT"
                                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                                let str: String = "Bearer " + ViewRouter.creds.jwt
                                request.setValue(str, forHTTPHeaderField: "Authorization")
                                
                                let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                                    (data, response, error) in
                                    guard let data = data else { return }
                                    print(String(data:data, encoding: .utf8)!)
                                    let httpResp = response as! HTTPURLResponse
                                    DispatchQueue.main.async {
                                        if httpResp.statusCode == 200 {
                                            self.update.toggle()
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                task.resume()
                                }, secondaryButton: .cancel())
                    }
                    Button(action:{
                        if self.reason.isEmpty{
                            self.show = true
                        }
                        else{
                            self.showAlert = true
                            self.show = false
                        }
                    }){
                        RejectButtonView()
                    }.frame(minWidth: 0, idealWidth: 50, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                        .alert(isPresented: $showAlert){ () -> Alert in
                            Alert(title: Text("Warning"), message: Text("Do you want to reject this doctor?"), primaryButton: .default(Text("OK")){
                                
                                self.show = false
                                let url = URL(string: "http://localhost:8080/admin/sendEmail")!
                                let json: [String: Any] = ["email": self.email, "reason": self.reason]
                                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                                var request = URLRequest(url: url)
                                request.httpMethod = "POST"
                                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                                let str: String = "Bearer " + ViewRouter.creds.jwt
                                request.setValue(str, forHTTPHeaderField: "Authorization")
                                
                                let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                                    (data, response, error) in
                                    guard let data = data else { return }
                                    print(String(data:data, encoding: .utf8)!)
                                    let httpResp = response as! HTTPURLResponse
                                    DispatchQueue.main.async {
                                        if httpResp.statusCode == 200 {
                                            self.update.toggle()
                                        }
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                task.resume()
                                
                                }, secondaryButton: .cancel())
                    }
                    TextView(placeholderText: "Reason", text: $reason)
                }
            }
        }
        
    }
}

struct DoctorDetail_Previews: PreviewProvider {
    static var previews: some View {
        DoctorDetail(username: "testUsername", name: "testDoctor", lastName: "testDoctor", job: "testJOB", describe: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea c", email: "asd", birthdate: "asd", update: .constant(false)).environmentObject(ViewRouter())
    }
}

struct ApproveButtonView: View {
    var body: some View {
        Text("Approve")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct RejectButtonView : View{
    var body: some View{
        Text("Reject")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
