//
//  HealthManager.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//


//Observable object to access my health data.
import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    //Set our variables
    let healthStore = HKHealthStore()
    
    //access and update variable
    @Published var healthStats: [HealthStat] = []
    
    //runs when healthmanager is launched
    init() {
        authoriseHealthAccess()
    }
    
    //check if we have authorised access to the health data.
    func authoriseHealthAccess(){
        
        //Check if we have access to the data
        if HKHealthStore.isHealthDataAvailable(){
            
            //Setup array for data we want and goining to use
            let dataTypes: Set = [
                //stepCount
                HKQuantityType(.stepCount),
                //heartRate - not really neaded
                HKQuantityType(.heartRate),
                //calouriesBurned
                HKQuantityType(.activeEnergyBurned)
            ]
                
            Task { //Task = async function
                do {
                    try await healthStore.requestAuthorization(toShare: [], read: dataTypes)
                    
                    print("Access granted to HealthKit")
                    //Start Accessing Our data
                    getStepCounts()
                    
                } catch {
                    print("Error handling HealthKit Access.")
                }
            }
            
        }
        
    }
    
    //go get the data.
    
    //can refactor code - less code
    func getStepCounts() {
        let steps = HKQuantityType(.stepCount) // what we want to access
        // timeframe - predicate (time perioud we want)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        //handling errors when get fails
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, results, error in
            
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting step counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let stepCountValue = quantity.doubleValue(for: .count())
            
            self.healthStats.append(HealthStat(
                title: "Total Steps",
                amount: "\(stepCountValue.rounded(.towardZero))",
                image: "figure.walk",
                color: .gray)
            )
            
        }
        
        healthStore.execute(query)
    }
    
}
