//
//  AddImageView.swift
//  courseWork
//
//  Created by alexander tsay on 09.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import Alamofire

struct AddImageView: View {
    @State var image: Image?
    var body: some View {
        VStack{
            image
        }.onAppear(){
            AF.download("http://localhost:8080/upload").responseData{ response in
                if let data = response.value{
                    self.image = Image(uiImage: (UIImage(data: data) ?? nil)!)
                }
            }
        }
    }
}
struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView()
    }
}
