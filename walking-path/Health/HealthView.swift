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
        
        NavigationView {
            
            VStack {
                
                Text("")
                    .navigationTitle("Dashboard")
                
                List {
                    
                    ForEach(manager.healthStats){ item in
                        NavigationLink(destination:
                                        HealthSingleView(item: item)){
                            HStack {
                                Text(item.title)
                            }
                        }//NavigationLink - end
                    }//ForEach - end
                }//List - end
            }//VStack
        }//navigationView - end
        
//        VStack {
//            ForEach(manager.healthStats){tracking in
//                VStack{
//                    Text(tracking.title)
//                        .foregroundStyle(Color.white)
//                    Text(tracking.amount)
//                        .foregroundStyle(Color.white)
//                    Image(systemName: tracking.image)
//                        .foregroundStyle(Color.white)
//                }
//                .background(tracking.color)
//                .padding()
//            }
//        }
//        .padding()
    }
}

#Preview {
    HealthView()
}
