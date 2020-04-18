//
//  DoctorSignUpView.swift
//  courseWork
//
//  Created by alexander tsay on 11.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct DoctorSignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    
    
    @State var username: String = ""
    @State var password: String = ""
    @State var repPas: String = ""
    @State var name: String = ""
    @State var lastName: String = ""
    @State var job:String = ""
    @State var email: String = ""
    @State var birthDate = Date()
    @State var describe:String = ""
    @State var invalidData = false
    @State var notEqualPass = false
    @State var weakPass = false
    @State var usernameExist = false
    @State var value : CGFloat = 0
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.viewRouter.currentPage = "login"
                }){
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("Back")
                }.padding()
                Spacer()
            }
            Form {
                VStack {
                    Group{
                        Text("Are u a doctor?").font(.title)
                        TextField("Enter your username", text: $username).padding().autocapitalization(.none)
                        SecureField("Enter your password", text: $password).padding()
                        SecureField("Confirm your password", text: $repPas).padding()
                        TextField("Enter your first name", text: $name).padding()
                        TextField("Enter your last name", text: $lastName).padding()
                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date){
                            Text("Enter your birthDate")
                        }.padding()
                        TextField("Enter your email", text: $email).padding()
                        TextField("Enter your job position", text: $job).padding()
                        TextView(placeholderText: "Describe yourself(max. 255 symbols)", text: $describe).frame(numLines: 4).padding()
                    }
                    Group{
                        if invalidData {
                            Text("Invalid data entered").foregroundColor(.red)
                        }
                        if notEqualPass {
                            Text("Passwords are not equal").foregroundColor(.red)
                        }
                        
                        if weakPass{
                            Text("Weak password").foregroundColor(.red)
                        }
                        if usernameExist{
                            Text("This username is already used").foregroundColor(.red)
                        }
                    }
                    
                }
                VStack {
                    Button(action: {
                        if(!self.check()){
                            self.invalidData = true
                            self.notEqualPass = false
                            self.weakPass = false
                            self.usernameExist = false
                        } else if (self.password != self.repPas){
                            self.notEqualPass = true
                            self.invalidData = false
                            self.weakPass = false
                            self.usernameExist = false
                        }else if !self.checkPass(){
                            self.weakPass = true
                            self.notEqualPass = false
                            self.invalidData = false
                            self.usernameExist = false
                        }
                            
                        else {
                            let json: [String: Any] = ["username": self.username, "password": self.password, "name": self.name, "lastName": self.lastName, "job": self.job, "email": self.email, "birthdate": self.birthDate.description, "describe": self.describe]
                            print(json)
                            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                            let url = URL(string: "http://localhost:8080/registration/doctor")!
                            var request = URLRequest(url: url)
                            request.httpMethod = "POST"
                            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                            
                            let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                                (data, response, error) in
                                let httpResp = response as! HTTPURLResponse
                                DispatchQueue.main.async {
                                    print(httpResp.statusCode)
                                    if httpResp.statusCode == 200 {
                                        self.viewRouter.currentPage = "login"
                                    } else if httpResp.statusCode == 403{
                                        self.usernameExist = true
                                        self.weakPass = false
                                        self.notEqualPass = false
                                        self.invalidData = false
                                    }
                                }
                            }
                            task.resume()
                        }
                    }){
                        SignUpButtonContent()
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }.offset(y: -self.value).animation(.spring()).onAppear(){
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                    (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.value = height / 3
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                    (noti) in
                    self.value = 0
                }
            }
        }
    }
    
    func check() -> Bool {
        
        if self.username.isEmpty{
            return false
        }
        if self.password.isEmpty{
            return false
        }
        if self.repPas.isEmpty{
            return false
        }
        if self.name.isEmpty{
            return false
        }
        if self.lastName.isEmpty{
            return false
        }
        if self.job.isEmpty{
            return false
        }
        
        return true
    }
    
    func checkPass() -> Bool{
        let pattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let reg = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self.password)
        print(reg)
        return reg
    }
}

struct DoctorSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorSignUpView().environmentObject(ViewRouter())
    }
}
