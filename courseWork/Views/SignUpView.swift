//
//  SignUpView.swift
//  courseWork
//
//  Created by alexander tsay on 28.01.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var username: String = ""
    @State var password: String = ""
    @State var repPas: String = ""
    @State var email: String = ""
    @State var empCredentials = false
    @State var notEqualPass = false
    @State var registered = false
    @State var invalidEmail = false
    
    @State var value : CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.viewRouter.currentPage = "login"
                }){
                    Image(systemName: "arrowshape.turn.up.left")
                    Text("Back")
                }.padding()
                Spacer()
            }
            Spacer()
            Text("Sign Up").font(.title).padding()
            VStack {
                TextField("Enter your username", text: $username).padding().autocapitalization(.none)
                SecureField("Enter your password", text: $password).padding()
                SecureField("Confirm your password", text: $repPas).padding()
                TextField("Enter your email", text: $email).padding()
            }
            if empCredentials {
                Text("Invalid information. Try again")
                    .foregroundColor(.red)
            }
            if notEqualPass {
                Text("Passwords are not equal")
                    .foregroundColor(.red)
            }
            if invalidEmail{
                Text("Invalid email address")
                    .foregroundColor(.red)
            }
            if registered {
                Text("This user is already registred")
                    .foregroundColor(.red)
            }
            Button(action: {
                if(self.username.isEmpty || self.password.isEmpty || self.repPas.isEmpty){
                    self.empCredentials = true
                    self.notEqualPass = false
                    self.invalidEmail = false
                    self.registered = false
                }
                else if(self.password != self.repPas){
                    self.notEqualPass = true
                    self.empCredentials = false
                    self.invalidEmail = false
                    self.registered = false
                }
                else if(self.isValidEmail(self.email)){
                    self.notEqualPass = false
                    self.empCredentials = false
                    self.registered = false
                    self.invalidEmail = true
                }
                else {
                    self.notEqualPass = false
                    self.empCredentials = false
                    self.registered = false
                    self.invalidEmail = false
                    let json: [String: Any] = ["username": self.username, "password": self.password, "email": self.email]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                    let url = URL(string: "http://localhost:8080/registration/user")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                    
                    let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                        (data, response, error) in
                        guard let data = data else { return }
                        print(String(data:data, encoding: .utf8)!)
                        let httpResp = response as! HTTPURLResponse
                        DispatchQueue.main.async {
                            if httpResp.statusCode == 200 {
                                self.viewRouter.currentPage = "login"
                            }
                            if httpResp.statusCode == 403 {
                                self.registered = true
                            }
                        }
                    }
                    task.resume()
                }
            }){
                SignUpButtonContent()
            }.padding()
            Spacer()
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct SignUpButtonContent: View {
    var body: some View {
        Text("REGISTER")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(ViewRouter())
    }
}
