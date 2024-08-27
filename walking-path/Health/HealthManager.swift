//
//  HealthManager.swift
//  walking-path
//
//  Created by student on 2024/08/11.
//


//Observable object to access my health data.
import Foundation
import HealthKit
import WidgetKit

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
                    getStepCounts(for: TimePeriod.day)
                    
                } catch {
                    print("Error handling HealthKit Access.")
                }
            }
            
        }
        
    }
    
    //go get the data.
    //can refactor code - less code
    //go get the data.
    func getStepCounts(for period: TimePeriod) {
        // Clear the list before adding new data
        DispatchQueue.main.async {
            self.healthStats.removeAll()
        }
        
        let steps = HKQuantityType(.stepCount) // what we want to access
        let activity = HKQuantityType(.activeEnergyBurned)
        let resting = HKQuantityType(.basalEnergyBurned)
        let walkRun = HKQuantityType(.distanceWalkingRunning)
        let floor = HKQuantityType(.flightsClimbed)
        
        let dateRange = dateRange(for: period)
        
        // timeframe - predicate (time period we want)
        let predicate = HKQuery.predicateForSamples(withStart: dateRange.startDate, end: dateRange.endDate, options: .strictStartDate)
        
        // steps
        let stepQuery = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting step counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let stepCountValue = quantity.doubleValue(for: .count())
            
            self.updateWidget(newSteps: stepCountValue)
            
            DispatchQueue.main.async {
                self.healthStats.append(HealthStat(
                    title: "Steps",
                    amount: "\(stepCountValue.rounded(.towardZero)) steps",
                    image: "figure.walk",
                    color: .secondary)
                )
            }
        }
        
        // activity
        let activityQuery = HKStatisticsQuery(quantityType: activity, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting burned kcal counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let kcalBurned = quantity.doubleValue(for: .largeCalorie())
            DispatchQueue.main.async {
                self.healthStats.append(HealthStat(
                    title: "Active Energy",
                    amount: "\(kcalBurned.rounded()) kcal",
                    image: "flame.fill",
                    color: .secondary)
                )
            }
        }
        
        // resting energy
        let restingQuery = HKStatisticsQuery(quantityType: resting, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting resting kcal counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let kcal = quantity.doubleValue(for: .largeCalorie())
            DispatchQueue.main.async {
                self.healthStats.append(HealthStat(
                    title: "Resting Energy",
                    amount: "\(kcal.rounded()) kcal",
                    image: "flame",
                    color: .secondary)
                )
            }
        }
        
        // walk/run distance
        let walkRunQuery = HKStatisticsQuery(quantityType: walkRun, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting walk and run counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let distance = quantity.doubleValue(for: .meter())
            DispatchQueue.main.async {
                self.healthStats.append(HealthStat(
                    title: "Walking + Running",
                    amount: "\(distance.rounded()) m",
                    image: "figure.run",
                    color: .secondary)
                )
            }
        }
        
        // floors climbed
        let floorQuery = HKStatisticsQuery(quantityType: floor, quantitySamplePredicate: predicate) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                print("Error getting floor counts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let floors = quantity.doubleValue(for: .count())
            DispatchQueue.main.async {
                self.healthStats.append(HealthStat(
                    title: "Flights Climbed",
                    amount: "\(floors)",
                    image: "figure.stairs",
                    color: .secondary)
                )
            }
        }
        
        healthStore.execute(stepQuery)
        healthStore.execute(activityQuery)
        healthStore.execute(restingQuery)
        healthStore.execute(walkRunQuery)
        healthStore.execute(floorQuery)
    }

    func updateWidget(newSteps: Double)
    {
        
        let defaults = UserDefaults(suiteName: "group.co.za.openwindow.walking-path") // <-- points to the group
        
        defaults?.set(newSteps, forKey: "totalSteps")
        
        //trigger refresh
        WidgetCenter.shared.reloadAllTimelines()
        
    }
    
}



