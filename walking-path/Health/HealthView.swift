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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HealthView()
}
