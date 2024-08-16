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
                //resting energy
                HKQuantityType(.basalEnergyBurned),
                //activity
                HKQuantityType(.activeEnergyBurned),
                //walking + running distance
                HKQuantityType(.distanceWalkingRunning),
                //floor
                HKQuantityType(.flightsClimbed)
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
        let activity = HKQuantityType(.activeEnergyBurned)
        let resting = HKQuantityType(.basalEnergyBurned)
        let walkRun = HKQuantityType(.distanceWalkingRunning)
        let floor = HKQuantityType(.flightsClimbed)
        
        // timeframe - predicate (time perioud we want)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
        
        //handling errors when get fails
        
        //steps
        let stepQuery = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting step counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let stepCountValue = quantity.doubleValue(for: .count())
            
            self.healthStats.append(HealthStat(
                title: "Steps",
                amount: "\(stepCountValue.rounded(.towardZero)) steps",
                image: "figure.walk",
                color: .secondary)
            )
        }
        //activity
        
        let activityQuery = HKStatisticsQuery(quantityType: activity, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting burned kcal counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let kcalBurned = quantity
            
            self.healthStats.append(HealthStat(
                title: "Active Energy",
                amount: "\(kcalBurned) kcal",
                image: "flame.fill",
                color: .secondary)
            )
        }
        
        //resting Energy
        
        let restingQuery = HKStatisticsQuery(quantityType: resting, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting resting kcal counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let kcal = quantity
            
            self.healthStats.append(HealthStat(
                title: "Resting Energy",
                amount: "\(kcal) kcal",
                image: "flame.fill",
                color: .secondary)
            )
        }
        
        //walkRun
        let walkRunQuery = HKStatisticsQuery(quantityType: walkRun, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting walk and run counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let distance = quantity
            
            self.healthStats.append(HealthStat(
                title: "Walking + Running",
                amount: "\(distance) km",
                image: "flame.fill",
                color: .secondary)
            )
        }
        
        //floors
        let floorQuery = HKStatisticsQuery(quantityType: floor, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting floor counts: \(error?.localizedDescription)")
                
                return
            }
            
            //this is our step count
            let floors = quantity
            
            self.healthStats.append(HealthStat(
                title: "Flights Climbed",
                amount: "\(floors) floor",
                image: "flame.fill",
                color: .secondary)
            )
        }
        
        healthStore.execute(stepQuery)
        healthStore.execute(activityQuery)
        healthStore.execute(restingQuery)
        healthStore.execute(walkRunQuery)
        healthStore.execute(floorQuery)
    }
    
}
