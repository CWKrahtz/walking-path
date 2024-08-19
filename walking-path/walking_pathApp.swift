//
//  walking_pathApp.swift
//  walking-path
//
//  Created by student on 2024/08/07.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct walking_pathApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init() {
//        FirebaseApp.configure()
//    }
    
    @ObservedObject var firebaseAuthManager = FirebaseAuthManager()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            
            //if is onboarded is false show onboarding screen else show login screen
            
            if(firebaseAuthManager.isAuthenticated == false){
                HealthView()
            } else {
                FirebaseAuthView()
                    .environmentObject(firebaseAuthManager)
            }
            
        }
    }
}


#Preview {
    FirebaseAuthView()
        .environmentObject(FirebaseAuthManager())
}
