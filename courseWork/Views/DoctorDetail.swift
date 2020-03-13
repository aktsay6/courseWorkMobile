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
    
    @Binding var update: Bool
    
    var body: some View {
        VStack {
            Text(name).font(.title)
            Text(lastName).font(.title)
            Divider()
            Text(job).font(.title)
            Button(action:{
                let url = URL(string: "http://localhost:8080/admin/update/" + self.username)!
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
                        }
                    }
                }
                task.resume()
            }){
                ApproveButtonView()
            }.padding()
        }
        
    }
}

struct DoctorDetail_Previews: PreviewProvider {
    static var previews: some View {
        DoctorDetail(username: "testUsername", name: "testDoctor", lastName: "testDoctor", job: "testJOB", update: .constant(false))
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
