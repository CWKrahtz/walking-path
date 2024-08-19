//
//  SettingsSheet.swift
//  walking-path
//
//  Created by student on 2024/08/19.
//

import SwiftUI

struct SettingsSheet: View {
    
    //@Environment var = define the environment/context of our application
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                Text("Settings")
                    .font(.title)
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .onTapGesture {//On Click modifier == Button
                        dismiss()
                    }
            }
            
            GroupBox{
                HStack{
                    Text("Developecd by:")
                    Spacer()
                    Link("Christian Krahtz", destination: URL(string: "https://github.com/CWKrahtz/walking-path.git")!)
                        .bold()
                    Image(systemName: "link")
                }
                Divider()
                HStack{
                    Text("App Name:")
                    Spacer()
                    Text("Walkin Path")
                        .bold()
                }
                Divider()
                HStack{
                    Text("Version:")
                    Spacer()
                    Text("1.0.0")
                        .bold()
                }
            }//END - GroupBox
            
            Divider().padding()
            
            GroupBox{
                DisclosureGroup("About The App"){
                    Text("This is Walking Path, a mobile application that keeps track of your health data (using HealthKit) and lets you track your location for the day when set to track. This application was created for iOS: Expanded 303 at Open Window.")
                        .padding()
                        .bold(false)
                }
                .bold()
                
                Divider()
                
                DisclosureGroup("About Developer"){
                    Text("My name is Christian Krahtz, I am a third year student majoring in Development. I found it hard to manage my time for when to be on campus and when to work on the project. I usually work on campus over weekends and after campus hours in order to complete this project.")
                        .padding()
                        .bold(false)
                }
                .bold()
            }
            Spacer()
        }//END - VStack
        .padding()
    }
}

#Preview {
    SettingsSheet()
}
