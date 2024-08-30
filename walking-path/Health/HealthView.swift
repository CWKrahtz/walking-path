//
//  HealthView.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//

import SwiftUI
import FirebaseAuth

struct HealthView: View {
    
    @ObservedObject var manager = HealthManager()
    @State private var selectedPeriod: TimePeriod = .day //default filter select
    
    func signOut(){
        var firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        }
        catch{
            print("User already signed out")
        }
    }
    
    //var to toggle settings sheet
    //@State = useState -> Can Update Values
    @State var showSettings: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                //Filter
                Picker("Select Time Period", selection: $selectedPeriod) 
                {
                    Text("Day").tag(TimePeriod.day)
                    Text("Week").tag(TimePeriod.week)
                    Text("Month").tag(TimePeriod.month)
                    Text("Year").tag(TimePeriod.year)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(manager.healthStats) { item in
                        NavigationLink(
                            destination: HealthSingleView(
                                item: item,
                                dayGoal: 0,
                                weekGoal: 0,
                                monthGoal: 0, 
                                yearGoal: 0,
                                periodSelected: "",
                                userProgress: 0,
                                selectedPeriod: selectedPeriod
                            )) {
                            HStack {
                                Text(item.title)
                            }
                        }
                    }
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
                .navigationBarItems(leading: Button(action: {
                    //open settings/about
                    signOut()
                }){
                    Image(systemName: "signpost.left")
                        .foregroundColor(.primary)
                })
            }//VStack
            .onChange(of: selectedPeriod) { _ in
                manager.getStepCounts(for: selectedPeriod) // Call the new method
            }
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
