//
//  AdminView.swift
//  courseWork
//
//  Created by alexander tsay on 18.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct AdminView: View {
    
    @State var doctors: [Doctor] = []
    @State var update = false
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Text("Doctor list").font(.title)
                }
                List(doctors){ doctor in
                    DoctorCell(update: self.$update, doctor: doctor)
                }.onAppear(){
                    self.doctors = []
                    let url = URL(string: "http://localhost:8080/admin/users")!
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
                            self.doctors.append(Doctor(name: subJson["name"].stringValue, lastName: subJson["lastName"].stringValue, job: subJson["job"].stringValue, username: subJson["username"].stringValue, describe: subJson["describe"].stringValue, email: subJson["email"].stringValue, birthdate: String(subJson["birth"].stringValue.prefix(10))))
                        }
                    }.resume()
                }
            }
        }.navigationBarTitle(Text("Doctors"))
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView(doctors: testData)
    }
}

struct DoctorCell: View{
    @Binding var update:Bool
    let doctor: Doctor
    var body: some View{
        return NavigationLink(destination: DoctorDetail(username: doctor.username, name: doctor.name, lastName: doctor.lastName, job: doctor.job, describe: doctor.describe, email: doctor.email, birthdate: doctor.birthdate,update: $update)){
            HStack{
                Text(doctor.name).font(.title)
                Text(doctor.lastName).font(.title)
            }
        }
    }
}

