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
            ForEach(manager.healthStats){tracking in
                VStack{
                    Text(tracking.title)
                        .foregroundStyle(Color.white)
                    Text(tracking.amount)
                        .foregroundStyle(Color.white)
                    Image(systemName: tracking.image)
                        .foregroundStyle(Color.white)
                }
                .background(tracking.color)
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    HealthView()
}
