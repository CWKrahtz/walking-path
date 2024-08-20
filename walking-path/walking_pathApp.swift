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
    
    @State var isLoggedin: Bool = false
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            
            //if is onboarded is false show onboarding screen else show login screen
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
            }
        }//window - end
    }//body - end
}


#Preview {
    FirebaseAuthView()
        .environmentObject(FirebaseAuthManager())
}
