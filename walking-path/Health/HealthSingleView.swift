//
//  HealthSingleView.swift
//  walking-path
//
//  Created by student on 2024/08/18.
//

import SwiftUI
import Charts

struct HealthSingleView: View {
    
    var item: HealthStat?
    
    @State var dayGoal: Double
    @State var weekGoal: Double
    @State var monthGoal: Double
    @State var yearGoal: Double
    
    @State var periodSelected = ""
    
    @State var userProgress: Double
    
    var selectedPeriod: TimePeriod
    
    //Func to get %
    //get % from goal.
    
    //Set goals for activities
    func getPers() {
        guard let itemTitle = item?.title else { return }

        switch itemTitle {
        case "Steps":
            dayGoal = 10000
            weekGoal = 70000
            monthGoal = 310000
            yearGoal = 3650000
        case "Active Energy":
            dayGoal = 400
            weekGoal = 2800
            monthGoal = 12400
            yearGoal = 146000
        case "Resting Energy":
            dayGoal = 1600
            weekGoal = 11200
            monthGoal = 49600
            yearGoal = 584000
        case "Walking + Running":
            dayGoal = 15000
            weekGoal = 105000
            monthGoal = 465000
            yearGoal = 5475000
        case "Flights Climbed":
            dayGoal = 5
            weekGoal = 35
            monthGoal = 155
            yearGoal = 1825
        default:
            break
        }
        
        calculatePers()
    }
    
    //caculate persentage of progress
    func calculatePers(){
        guard let amount = item?.amount else {
            userProgress = 0.0
            return
        }
        
        switch selectedPeriod {
            case .day:
                userProgress = (amount / dayGoal) * 100
            periodSelected = "\(item!.title) / Day"
            case .week:
                userProgress = (amount / weekGoal) * 100
                periodSelected = "\(item!.title) / Week"
            case .month:
                userProgress = (amount / monthGoal) * 100
                periodSelected = "\(item!.title) / Month"
            case .year:
                userProgress = (amount / yearGoal) * 100
                periodSelected = "\(item!.title) / Year"
        }
    }
    
    var body: some View {
        NavigationView {
        
            VStack{
                Text("")
                    .navigationTitle(periodSelected)
                    .navigationBarTitleDisplayMode(.large)
                
                VStack(spacing: 0){
                    Text("Total of")
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    
                    HStack{
                        Text("\(item!.amount.formatted())")
                            .font(.title)
                        Text(item!.title)
                            .foregroundStyle(Color.secondary)
                            .font(.title)
                        Image(systemName: item!.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding()
    
                //Grid + data
                    GeometryReader{ metrics in
                        ZStack(alignment: .leading){
                            ZStack(alignment: .trailing){
                                //Goal bar
                                Capsule(style: .continuous)
                                    .fill(item!.color)
                                    .frame(width: .infinity, height: 50)
                                
                                Text("\(String(format: "%.2f", (100 - userProgress)))%")
                                    .foregroundColor(.white)
                                    .padding()
                                    
                            }//ZStack Goal - end
                            
                            ZStack{
                                
                                Capsule(style: .continuous)
                                    .fill(.blue)
                                    .frame(width: metrics.size.width * 0.25, height: 50)
                                
                                //progress bar
                                Capsule(style: .continuous)
                                    .fill(.blue)
                                    .frame(maxWidth: metrics.size.width * (userProgress / 100), idealHeight: 50, maxHeight: 50)
                                
                                //progress text
                                Text("\(String(format: "%.2f", userProgress))%")
                                    .foregroundColor(Color("Progress"))
                                    .padding()
                            }//ZStack progress - end
                            
                            
                        }//ZStack - end
                        .padding()
                    }//Geometry - end
                
                Spacer()
                
            }// VStack - outer end
            .onAppear(perform: getPers)
            
        }
    }//body - end
    
        
}

#Preview {
    HealthSingleView(
        dayGoal: 0,
        weekGoal: 0,
        monthGoal: 0,
        yearGoal: 0,
        userProgress: 0,
        selectedPeriod: .day
    )
}
