//
//  HealthView.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//

import SwiftUI

struct HealthView: View {
    
    @ObservedObject var manager = HealthManager()
    
    var body: some View {
        VStack {
            ForEach(manager.healthStats){steps in
                VStack{
                    Text("ForEach Loop")
                    Text(steps.title)
                    Text(steps.amount)
                    Image(steps.image)
                }
                .background(steps.color)
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    HealthView()
}
