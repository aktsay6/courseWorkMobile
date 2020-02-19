//
//  LoginView.swift
//  courseWork
//
//  Created by alexander tsay on 28.01.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import SwiftyJSON

let lightGreyColor : Color = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView: View {
    @State var username : String = ""
    @State var password : String = ""
    @State var value : CGFloat = 0
    
    @State var invalidData = false
    @State var signingIn = false
    @State var authFailed = false
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Welcome!").bold().font(.title)
                UserNameField(username: $username)
                PasswordField(password: $password)
                if invalidData{
                    Text("Invalid information. Try again")
                        .foregroundColor(.red)
                }
                
                if authFailed {
                    Text("No such user")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    if self.username.isEmpty || self.password.isEmpty{
                        self.invalidData = true
                        self.authFailed = false
                    } else{
                        self.signingIn = true
                        self.invalidData = false
                        self.authFailed = false
                        let json: [String: Any] = ["username": self.username, "password": self.password]
                        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                        let url = URL(string: "http://localhost:8080/authenticate")!
                        var request = URLRequest(url: url)
                        
                        request.httpMethod = "POST"
                        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                        
                        
                        let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                            (data, response, error) in
                            let json = JSON(data)
                            let jwt = json["jwt"].stringValue
                            let role = json["role"].stringValue
                            print(role)
                            let httpResp = response as! HTTPURLResponse
                            DispatchQueue.main.async {
                                if httpResp.statusCode == 200 {
                                    self.viewRouter.currentPage = "main"
                                    ViewRouter.jwt = jwt
                                    self.viewRouter.role = role
                                    self.authFailed = false
                                }else{
                                    self.authFailed = true
                                }
                                self.signingIn = false
                            }
                        }
                        task.resume()
                    }
                })
                {
                    LoginButtonContent()
                }.padding()
                
                Button(action: {
                    self.viewRouter.currentPage = "signup"
                }){
                    Text("Create an account").foregroundColor(.blue)
                }
            }.padding()
                .offset(y: -self.value).animation(.spring()).onAppear(){
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
            if signingIn {
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewRouter())
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
        
    }
}

struct UserNameField: View {
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username).padding()
            .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
    }
}

struct PasswordField: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password).padding()
            .cornerRadius(4.0).background(lightGreyColor)
    }
}

struct Loader: View{
    @State var animate = false
    
    var body : some View{
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors: [.red,.orange]), center: .center), style: StrokeStyle( lineWidth: 8, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
            Text("Please Wait...").padding(.top)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(15)
        .onAppear(){
            self.animate.toggle()
        }
    }
}
