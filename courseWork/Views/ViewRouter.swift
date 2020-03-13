//
//  ViewRouter.swift
//  courseWork
//
//  Created by alexander tsay on 12.02.2020.
//  Copyright © 2020 alexander tsay. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    @ObservedObject var chat = ChatController()
    
    
    @Published var currentPage: String = "login" {
        willSet {
            withAnimation() {
              objectWillChange.send(self)
            }
        }
    }
    
    @Published var role: String = "user"
    public static var creds: UserCredentials = UserCredentials()
}
