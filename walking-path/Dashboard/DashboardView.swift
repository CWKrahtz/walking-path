//
//  DashboardView.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        
//        Button(action: {
//            //Navigate to HealthView
//        }){
//            Text("To Single View")
//        }
        
        NavigationView {
            Text("Hello")
                .navigationTitle("Dashboard")
        }
        
    }
}

#Preview {
    DashboardView()
}
