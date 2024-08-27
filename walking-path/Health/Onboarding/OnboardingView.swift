//
//  OnboardingView.swift
//  walking-path
//
//  Created by student on 2024/08/19.
//

import SwiftUI

struct OnboardingView: View {
    
    //Calls to get access to HealthApp / HealthKit
//    @ObservedObject var manager = HealthManager()
    
    @AppStorage("isOnboarded") var isOnboarded = false
    
    var body: some View {
        VStack {
            
            TabView{
                //Tab 1
                OnboardingCardView(
                    title: "Welcome",
                    description: "Welcome to Walking Path, the best health tracking app",
                    icon: "suit.heart"
                )
                .padding()
                
                //Tab 2
                OnboardingCardView(
                    title: "Tacking",
                    description: "The main objective of the app is to showcase your health stats in a single place",
                    icon: "location"
                )
                .padding()
                
                //Tab 3
                VStack {
                    OnboardingCardView(
                        title: "Permissions",
                        description: "Please provide the relevent permittions to access your HealthApp",
                        icon: "lock.app.dashed"
                    )
                    .padding()
                    
                    Button(action: {
                        //Update AppStorage
                        isOnboarded.toggle()
                    }){
                        HStack {
                            Text("Continue")
                                .padding()
                                .foregroundColor(Color(.white))
                            Image(systemName: "arrow.right.circle.fill")
                                .padding()
                                .foregroundColor(Color(.white))
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                
            }//Tab - end
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            
            
        }//Outer VStack - end
    }
}

#Preview {
    OnboardingView()
}
