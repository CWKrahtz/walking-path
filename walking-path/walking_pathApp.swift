//
//  walking_pathApp.swift
//  walking-path
//
//  Created by student on 2024/08/07.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct walking_pathApp: App {
    
    //AppStorage Variable to determine if the user needs to be onboarded or not
    @AppStorage("isOnboarded") var isOnboarded: Bool = false
    
    //Check if user is loged in or not
    @State var isLoggedin: Bool = false
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            
            //If onboarding is true  -> display login/dashboard
            //If onboarding is false -> show Onboarding Screen
            if(isOnboarded){
                ZStack{
                       if(isLoggedin){
                           HealthView()
                       } else {
                           FirebaseAuthView()
                       }//if/else - end
                   }//ZStack - end
                   .onAppear{
                       var handler = Auth.auth().addStateDidChangeListener { auth, user in
                           if user != nil {
                               self.isLoggedin = true
                               print("Authenticated")
                           }
                           else {
                               self.isLoggedin = false
                               print("Not Authenticated")
                           }
                       }
                   }//onAppear - end
            } else {
                OnboardingView()
            }
            
        }//window - end
    }//body - end
}


#Preview {
    FirebaseAuthView()
        .environmentObject(FirebaseAuthManager())
}
