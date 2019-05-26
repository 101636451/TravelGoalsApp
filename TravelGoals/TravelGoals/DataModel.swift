//
//  DataModel.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 25/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import Foundation

//{"trips" : [ {"name":"Honeymoon","country":"Sri Lanka","startDate":"28/08/2019","endDate":"02/09/2019","description":"Going to enjoy sun", "iscompleted":0,"plans":[{"plan_name":"surfing","plan_date":"29/08/2019", "plan_time":"08:00 am", "plan_description":"surfing in down south"}]}]}

struct TripList: Codable {
    var trips : [Trip]
    
    enum CodingKeys : String, CodingKey {
        case trips = "trips"
    }
}

struct Trip: Codable {
    var name: String
    var country: String
    var startDate: String
    var endDate: String
    var description: String
    var isCompleted: Int
    var plans : [Plan]
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case country = "country"
        case startDate = "startDate"
        case endDate = "endDate"
        case description = "description"
        case isCompleted = "iscompleted"
        case plans = "plans"
    }
}

struct Plan: Codable {
    let planName: String
    let planDate: String
    let planTime: String
    let planDescription: String
    
    enum CodingKeys : String, CodingKey {
        case planName = "plan_name"
        case planDate = "plan_date"
        case planTime = "plan_time"
        case planDescription = "plan_description"
    }
}

func addTrip(pname:String, pcountry:String, pstartDate:String, pendDate:String, pdescription:String) -> Bool {
    
    var result : Bool = false
    let data = readFile()
    //var dataArray = [S]()
    let filemgr = FileManager.default
//    let strStartDate = "\(pstartDate)"
//    let strEndDate = "\(pendDate)"
    let tempPlans = [Plan]()
    
    let tempTrip = Trip(name: pname, country: pcountry, startDate: pstartDate, endDate: pendDate, description: pdescription, isCompleted: 0, plans: tempPlans)
    
    do {
        
        var tripList =  try JSONDecoder().decode(TripList.self, from: data)
        
        tripList.trips.append(tempTrip)
        
//        for student in studentList.students {
//            print("Student \(student.fname) \(student.lname) age = \(student.age)")
//        }
        
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true).first
        let fullDestPath = URL(fileURLWithPath: destPath!)
            .appendingPathComponent("trips.json")
        
        let fullDestPathString = fullDestPath.path
        
        if(filemgr.fileExists(atPath:fullDestPathString)) {
            
            let encodedData = try? JSONEncoder().encode(tripList)
            try encodedData!.write(to: fullDestPath)
            result = true
        }
        
    } catch {
        print("Error Writing to the json")
    }

    return result
}


func markTripAsCompleted(tripIndex:Int)-> Bool {
    var result : Bool = false
    
    let data = readFile()
    let filemgr = FileManager.default

    do {
        
        var tripList =  try JSONDecoder().decode(TripList.self, from: data)
        
        tripList.trips[tripIndex].isCompleted = 1
        
        //        for student in studentList.students {
        //            print("Student \(student.fname) \(student.lname) age = \(student.age)")
        //        }
        
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true).first
        let fullDestPath = URL(fileURLWithPath: destPath!)
            .appendingPathComponent("trips.json")
        
        let fullDestPathString = fullDestPath.path
        
        if(filemgr.fileExists(atPath:fullDestPathString)) {
            
            let encodedData = try? JSONEncoder().encode(tripList)
            try encodedData!.write(to: fullDestPath)
            result = true
        }
        
    } catch {
        print("Error Writing to the json")
    }
    
    return result

}

func addPlam(pname:String, pDate:String, pTime:String, pdescription:String, tripIndex:Int) -> Bool {
    
    var result : Bool = false
    let data = readFile()
    //var dataArray = [S]()
    let filemgr = FileManager.default
    //    let strStartDate = "\(pstartDate)"
    //    let strEndDate = "\(pendDate)"
    //let tempPlans = [Plan]()
    
    let tempPlan = Plan(planName: pname, planDate: pDate, planTime: pTime, planDescription: pdescription)
    
    do {
        
        var tripList =  try JSONDecoder().decode(TripList.self, from: data)
        
        tripList.trips[tripIndex].plans.append(tempPlan)
        
        //        for student in studentList.students {
        //            print("Student \(student.fname) \(student.lname) age = \(student.age)")
        //        }
        
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true).first
        let fullDestPath = URL(fileURLWithPath: destPath!)
            .appendingPathComponent("trips.json")
        
        let fullDestPathString = fullDestPath.path
        
        if(filemgr.fileExists(atPath:fullDestPathString)) {
            
            let encodedData = try? JSONEncoder().encode(tripList)
            try encodedData!.write(to: fullDestPath)
            result = true
        }
        
    } catch {
        print("Error Writing to the json")
    }
    
    return result
}

func readJson()-> [Trip]{
    var dataArray = [Trip]()
    let data = readFile()
    
    do {
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        print("\(jsonResult)")
        
        let trips =  try JSONDecoder().decode(TripList.self, from: data)
        
        for trip in trips.trips {

            var plansList = [Plan]()
            
            //print("\(trip.name) \(trip.country) \(trip.startDate) \(trip.endDate) \(trip.description) \(trip.isCompleted) ")
            
            for plan in trip.plans {
                let tempPlan = Plan(planName: plan.planName, planDate: plan.planDate, planTime: plan.planTime, planDescription: plan.planDescription)
                
                //print("Plans :\(plan.planName) \(plan.planDate) \(plan.planTime) \(plan.planDescription)")
                
                plansList.append(tempPlan)
            }

            let temp = Trip(name: trip.name, country: trip.country, startDate: trip.startDate, endDate: trip.endDate, description: trip.description, isCompleted: trip.isCompleted, plans: plansList)
            dataArray.append(temp)
        }
        
        //print("\(dataArray)")
        
    } catch {
        print("Error loading the json")
    }
    return dataArray
}

func readFile()->Data {
    
    let filemgr = FileManager.default
    
    var data : Data? = nil
    
    let filePath = Bundle.main.path(forResource: "trips", ofType: "json")
    let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                       .userDomainMask,
                                                       true).first
    let fullDestPath = URL(fileURLWithPath: destPath!)
        .appendingPathComponent("trips.json")
    let fullDestPathString = fullDestPath.path
    
    if(filemgr.fileExists(atPath:fullDestPathString)) {
        print("file available")
        do {
            //try filemgr.removeItem(atPath: fullDestPathString)
            //try FileManager.default.copyItem(atPath: filePath!, toPath: fullDestPathString)
            data = try Data(contentsOf: fullDestPath, options: .mappedIfSafe)
            
        } catch {
            print("Read failed:Existing")
        }
    } else {
        do {
            try FileManager.default.copyItem(atPath: filePath!, toPath: fullDestPathString)
            data = try Data(contentsOf: fullDestPath, options: .mappedIfSafe)
            
        } catch {
            print("Read failed:Non Existing")
        }
        
    }
    return data!
}


