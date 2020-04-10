//
//  ImagePicker.swift
//  courseWork
//
//  Created by alexander tsay on 09.04.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import SwiftUI
import Alamofire

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isVisible:Bool
    @Binding var image:Image?
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(isVisible: $isVisible, image: $image)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        @Binding var isVisible:Bool
        @Binding var image:Image?
        
        init(isVisible: Binding<Bool>, image: Binding<Image?>){
            _isVisible = isVisible
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiimage)
            
            let imgData = uiimage.jpegData(compressionQuality: 0.2)!
            
            let parameters = ["name": ViewRouter.creds.userName] //Optional for extra parameter
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                } //Optional for extra parameters
            },
                to:"http://localhost:8080/upload").response(completionHandler: {response in
                    print(response)
                })
            
            isVisible = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isVisible = false
        }
    }
    
}
