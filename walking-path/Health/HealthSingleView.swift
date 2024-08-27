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
        NavigationView {
        
            VStack{
                Text("")
                    .navigationTitle(item!.title)
                    .navigationBarTitleDisplayMode(.inline)
                
                VStack{
                    Text("Total of")
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text(item!.amount)
                        Text(item!.title)
                            .foregroundStyle(Color.secondary)
                        Image(systemName: item!.image)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                VStack{
                    //Grid + data
                }
                .frame(width: 250, height: 250)
                .background(item!.color)
                
//                VStack{
                    //            Text(item!.title)
                    //                .foregroundStyle(Color.white)
                    //            Text(item!.amount)
                    //                .foregroundStyle(Color.white)
                    //            Image(systemName: item!.image)
                    //                .foregroundStyle(Color.white)
//                }//VStack - inner end
//                .background(.secondary)
//                .padding()
                
                Spacer()
                
            }// VStack - outer end
            
        }
    }//body - end
        
}

#Preview {
    HealthSingleView()
}
