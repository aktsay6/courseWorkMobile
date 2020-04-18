//
//  CheckBlanksView.swift
//  courseWork
//
//  Created by alexander tsay on 16.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct CheckBlanksView: View {
    
    @State var blanks: [Blank] = []
    @State var update = false
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("Blank list").font(.title)
                }
                List(blanks){ blank in
                    BlankCell(update: self.$update, blank: blank)
                }.onAppear(){
                    self.blanks = []
                    let url = URL(string: "http://localhost:8080/blank/get")!
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                    let str: String = "Bearer " + ViewRouter.creds.jwt
                    request.setValue(str, forHTTPHeaderField: "Authorization")
                    
                    URLSession.shared.dataTask(with: request){
                        (data, response, error) in
                        print("IN TASK")
                        let json = JSON(data)
                        for (_, subJson) : (String, JSON) in json{
                            self.blanks.append(Blank(name: subJson["name"].stringValue, lastName: subJson["lastName"].stringValue, job: subJson["job"].stringValue, describe: subJson["describe"].stringValue, email: subJson["email"].stringValue, birthdate: String(subJson["birth"].stringValue.prefix(10)),weight: subJson["weight"].stringValue, height: subJson["height"].stringValue, status: subJson["status"].stringValue, appealDate: subJson["appeal"].stringValue, gender: subJson["gender"].stringValue))
                        }
                    }.resume()
                }
            }
        }.navigationBarTitle(Text("Doctors"))
    }
}

struct CheckBlanksView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBlanksView()
    }
}


struct BlankCell: View{
    @Binding var update:Bool
    let blank: Blank
    var body: some View{
        return NavigationLink(destination: BlankDetails(name: blank.name, lastName: blank.lastName, job: blank.job, describe: blank.describe, email: blank.email, birthdate: blank.birthdate, weight: blank.weight, height: blank.height, status: blank.status, gender: blank.gender, update: $update)){
            HStack{
                Text(blank.name).font(.title)
                Text(blank.lastName).font(.title)
                Spacer()
                Text(blank.appealDate.prefix(10)).font(.callout)
            }
        }
    }
}
