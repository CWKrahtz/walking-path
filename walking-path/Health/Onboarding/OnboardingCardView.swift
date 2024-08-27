//
//  OnboardingCardView.swift
//  walking-path
//
//  Created by student on 2024/08/27.
//

import SwiftUI

struct OnboardingCardView: View {
    
    var title: String
    var description: String
    var icon: String
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
            Text(title)
                .font(.system(size: 45, weight: .heavy))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.white))
            
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.palette) //have multi colors
                .foregroundColor(.white)
                .frame(width: 140, height: 140)
                .padding()
            
            Text(description)
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundStyle(Color(.white))
            
        }//Vstack - end
        .padding(40)
        .frame(maxWidth: .infinity) // -> expand to full width
        .background(Color("OnboardingCardColor"))
        .cornerRadius(20)
        .shadow(color: .primary.opacity(0.25), radius: 20, x: 5, y: 5)
    }
}

#Preview {
    OnboardingCardView(title: "Welcome", description: "Welcome to Walking Path, the best health tracking app.", icon: "figure.walk")
}
