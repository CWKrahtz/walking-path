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
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, results, error in
            
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting step counts: \(error?.localizedDescription)")
                
                return
            }
            
            
                
        }
    }
    
}
