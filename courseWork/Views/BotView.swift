//
//  BotView.swift
//  courseWork
//
//  Created by alexander tsay on 01.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct BotView: View {
    
    var ans: HeartDisQuestions = HeartDisQuestions()
    
    var body: some View {
        Question1(ans: self.ans)
    }
}

struct BotView_Previews: PreviewProvider {
    static var previews: some View {
        BotView()
    }
}


struct Question1 : View {
    @State var switchQ : Bool = false
    @State var age: String = "0"
    @EnvironmentObject var viewRouter: ViewRouter
    var ans: HeartDisQuestions
    var body: some View {
        ZStack{
            if (switchQ){
                Question2(ans: self.ans).transition(.scale)
            }
            else{
                VStack {
                    Text("What is your age?").font(.largeTitle)
                    TextField("Enter your age", text: $age).padding()
                        .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
                    
                    Button(action:{
                        self.ans.answers["age"]
                            = Float(self.age)
                        self.switchQ = true
                    }){
                        Text("Apply")
                    }.buttonStyle(MyButtonStyle(color: .blue))
                    Button(action:{

                        self.viewRouter.currentPage = "main"
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }.padding()
            }
        }
    }
    
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
}

struct Question2 : View {
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
    
    var ans: HeartDisQuestions
    
    @State var switchQ : Bool = false
    @State var cigs: String = "0"
    @State var switchB = false
    var body: some View {
        ZStack{
            if (switchQ){
                Question3(ans: self.ans).transition(.scale)
            }
            else if(switchB){
                Question1(ans: self.ans).transition(.scale)
            }
            else{
                VStack {
                    Text("How much cigs per day do you smoke?").font(.largeTitle)
                    TextField("Enter your number", text: $cigs).padding()
                        .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
                    
                    Button(action:{
                        self.switchQ = true
                        self.switchB = false
                        self.ans.answers["cigs"] = Float(self.cigs)
                    }){
                        Text("Apply")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                    
                    Button(action:{
                        self.switchB = true
                        self.switchQ = false
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }.padding()
            }
        }
    }
}

struct Question3 : View {
    
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
    
    @State var switchB = false
    var ans: HeartDisQuestions
    @State var switchQ : Bool = false
    @State var chol: String = "0"
    var body: some View {
        ZStack{
            if (switchQ){
                Question4(ans: self.ans).transition(.scale)
            }
            else if(switchB){
                Question2(ans: self.ans).transition(.slide)
            }
            else{
                VStack {
                    Text("What is your cholesterol level?").font(.largeTitle)
                    TextField("Enter your number", text: $chol).padding()
                        .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
                    
                    Button(action:{
                        self.switchQ = true
                        self.switchB = false
                        self.ans.answers["chol"] = Float(self.chol)
                    }){
                        Text("Apply")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                    Button(action:{
                        self.switchB = true
                        self.switchQ = false
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }.padding()
            }
        }
    }
}

struct Question4 : View {
    
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
    
    var ans: HeartDisQuestions
    @State var switchQ : Bool = false
    @State var bp: String = "0"
    
    @State var switchB = false
    var body: some View {
        ZStack{
            if (switchQ){
                Question5(ans: self.ans).transition(.scale)
            }
            else if(switchB){
                Question3(ans: self.ans).transition(.slide)
            }
            else{
                VStack {
                    Text("What is your blood pressure level?").font(.largeTitle)
                    TextField("Enter your number", text: $bp).padding()
                        .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
                    
                    Button(action:{
                        self.switchQ = true
                        self.switchB = false
                        self.ans.answers["sysBP"] = Float(self.bp)
                    }){
                        Text("Apply")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                    Button(action:{
                        self.switchB = true
                        self.switchQ = false
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }.padding()
            }
        }
    }
}

struct Question5 : View {
    
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
    
    var ans: HeartDisQuestions
    @State var switchQ : Bool = false
    @State var glucose: String = "0"
    @State var switchB = false
    var body: some View {
        ZStack{
            if (switchQ){
                Question6(ans: self.ans).transition(.scale)
            }
            else if(switchB){
                Question4(ans: self.ans).transition(.slide)
            }
            else{
                VStack {
                    Text("What is your glucose level?").font(.largeTitle)
                    TextField("Enter your number", text: $glucose).padding()
                        .cornerRadius(4.0).background(lightGreyColor).autocapitalization(.none)
                    
                    Button(action:{
                        self.switchQ = true
                        
                        self.switchB = false
                        self.ans.answers["glucose"] = Float(self.glucose)
                    }){
                        Text("Apply")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                    Button(action:{
                        self.switchB = true
                        self.switchQ = false
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }.padding()
            }
        }
    }
}


struct Question6 : View {
    
    init(ans: HeartDisQuestions){
        self.ans = ans
    }
    
    var ans: HeartDisQuestions
    
    @State var gender: String = ""
    @State var switchB = false
    @State var isMale = false
    @State var isFemale = false
    @State var switchV = ""
    
    var body: some View {
        ZStack{
            VStack {
                if(switchV == "1"){
                    HeartAnswerView()
                }
                else if(switchV == "0"){
                    HeartAnswerViewFalse()
                }
                else if(switchB){
                    Question5(ans: self.ans).transition(.slide)
                }
                else{
                    Text("What is your gender?").font(.largeTitle)
                    Button(action:{
                        self.isMale = true
                        self.isFemale = false
                        self.gender = "1"
                    }){
                        Text("Male")
                    }.background(self.isMale ? Color.red : Color.green).padding()
                    
                    Button(action:{
                        self.gender = "0"
                        self.isFemale = true
                        self.isMale = false
                    }){
                        Text("Female")
                    }.background(self.isFemale ? Color.red : Color.green).padding()
                    
                    Button(action:{
                        self.ans.answers["sex"] = Float(self.gender)
                        let json = self.ans.answers
                        self.switchB = false
                        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
                        print(json)
                        let url = URL(string: "http://localhost:8008")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        let task = URLSession.shared.uploadTask(with: request, from: jsonData){
                            (data, response, error) in
                            let json = JSON(data)
                            var answer = json["answer"]
                            let httpResp = response as! HTTPURLResponse // Catch exception when server doesnt work
                            DispatchQueue.main.async {
                                if httpResp.statusCode == 200 {
                                    self.switchV = answer.stringValue
                                    
                                }
                            }
                        }
                        task.resume()
                    }){
                        Text("Send")
                    }.padding().buttonStyle(MyButtonStyle(color: .blue))
                    Button(action:{
                        self.switchB = true
                    }){
                        Text("Back")
                    }.buttonStyle(MyButtonStyle(color: .blue)).padding()
                }
            }.padding()
        }
    }
}


struct MyButtonStyle: ButtonStyle {
    var color: Color = .green
    
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
