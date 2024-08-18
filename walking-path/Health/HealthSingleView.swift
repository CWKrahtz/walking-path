//
//  HealthSingleView.swift
//  walking-path
//
//  Created by student on 2024/08/18.
//

import SwiftUI

struct HealthSingleView: View {
    
    var item: HealthStat?
    
    var body: some View {
        VStack{
            Text(item!.title)
                .foregroundStyle(Color.white)
            Text(item!.amount)
                .foregroundStyle(Color.white)
            Image(systemName: item!.image)
                .foregroundStyle(Color.white)
        }
        .background(item!.color)
        .padding()    }
}

#Preview {
    HealthSingleView()
}
