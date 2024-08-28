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
            case .week:
                userProgress = (amount / weekGoal) * 100
            case .month:
                userProgress = (amount / monthGoal) * 100
            case .year:
                userProgress = (amount / yearGoal) * 100
        }
    }
    
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
                        Text("\(item!.amount.rounded(.towardZero))")
                        Text(item!.title)
                            .foregroundStyle(Color.secondary)
                        Image(systemName: item!.image)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
    
                //Grid + data
                    GeometryReader{ metrics in
                        ZStack(alignment: .leading){
                            ZStack{
                                //progress bar
                                Capsule(style: .continuous)
                                    .fill(.blue)
                                    .frame(width: metrics.size.width * (userProgress / 100), height: 50)
                                
                                //progress text
                                Text("\(String(format: "%.2f", userProgress))%")
                                    .foregroundColor(.white)
                            }//ZStack progress - end
                            
                            ZStack(alignment: .trailing){
                                //Goal bar
                                Capsule(style: .continuous)
                                    .fill(item!.color)
                                    .frame(width: .infinity, height: 50)
                                
                                Text("\(String(format: "%.2f", (100 - userProgress)))%")
                                    .padding()
                                    .foregroundColor(.white)
                            }//ZStack Goal - end
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
