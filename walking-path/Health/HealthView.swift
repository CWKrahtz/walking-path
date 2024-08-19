//
//  HealthView.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//

import SwiftUI

struct HealthView: View {
    
    @ObservedObject var manager = HealthManager()
    
    //var to toggle settings sheet
    //@State = useState -> Can Update Values
    @State var showSettings: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
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
                .navigationTitle("Dashboard")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    //open settings/about
                    showSettings.toggle()
                }){
                    Image(systemName: "gearshape")
                        .foregroundColor(.primary)
                })
            }//VStack
        }//navigationView - end
        .sheet(isPresented: $showSettings){ // $ -> Tells variable that it can change
            SettingsSheet()
        }
        
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
