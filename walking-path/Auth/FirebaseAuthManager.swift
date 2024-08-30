//
//  FirebaseAuthManager.swift
//  walking-path
//
//  Created by student on 2024/08/07.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isAuthenticated = false
    @Published var errorMessage = ""
    
    func login () {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                print(error!.localizedDescription)
                self.errorMessage = error!.localizedDescription
                return //stops the function
            }
            
            if authResult != nil {
                self.isAuthenticated = true
                print("Logged in USER: \(authResult!.user.uid)")
                print(self.isAuthenticated)
            }
            
        }
    }
    
    func signup () {
        self.errorMessage = ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                print(error!.localizedDescription)
                self.errorMessage = error!.localizedDescription
                return //stops the function
            }
            
            if authResult != nil {
                self.isAuthenticated = true
                print("Signed up USER: \(authResult!.user.uid)")
            }
            
        }
    }
    
}
