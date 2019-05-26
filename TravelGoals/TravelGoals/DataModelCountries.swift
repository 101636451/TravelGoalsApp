////
////  DataModelCountries.swift
////  TravelGoals
////
////  Created by Manoj Bandara on 26/5/19.
////  Copyright © 2019 Manoj Bandara. All rights reserved.
////
//
import Foundation
//
///*
// { "countries" : [
// {
// "timezones": [
// "America/Aruba"
// ],
// "latlng": [
// 12.5,
// -69.96666666
// ],
// "name": "Aruba",
// "country_code": "AW",
// "capital": "Oranjestad"
// },
// {
// "timezones": [
// "Asia/Kabul"
// ],
// "latlng": [
// 33,
// 65
// ],
// "name": "Afghanistan",
// "country_code": "AF",
// "capital": "Kabul"
// }]}
//
// */
//
//struct CountryCodList: Codable {
//    var countriesCod : [CountryCod]
//
//    enum CodingKeys : String, CodingKey {
//        case countriesCod = "countries"
//    }
//}
//
//struct CountryCod: Codable {
//    let name: String
//    let latlng: [String]
//
//    enum CodingKeys : String, CodingKey {
//        case name = "name"
//        case latlng = "latlng"
//
//    }
//}
//
//
//func readJsonCountry()-> [CountryCod]{
//    var dataArray = [CountryCod]()
//    let data = readFileCountry()
//
//    do {
//        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//        print("\(jsonResult)")
//
//        let countriesList =  try JSONDecoder().decode(CountryCodList.self, from: data)
//
//        for country in countriesList.countriesCod {
//
//            var latlongList = [Int]()
//
//            //print("\(trip.name) \(trip.country) \(trip.startDate) \(trip.endDate) \(trip.description) \(trip.isCompleted) ")
//
//            for latllong in country.latlng {
//
//                latlongList.append(latllong)
//            }
//
//            let temp = CountryCod(name: country.name, latlng: latlongList)
//            dataArray.append(temp)
//        }
//
//        //print("\(dataArray)")
//
//    } catch {
//        print("Error loading the json")
//    }
//    return dataArray
//}
//
//func readFileCountry()->Data {
//
//    let filemgr = FileManager.default
//
//    var data : Data? = nil
//
//    let filePath = Bundle.main.path(forResource: "countries", ofType: "json")
//    let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
//                                                       .userDomainMask,
//                                                       true).first
//    let fullDestPath = URL(fileURLWithPath: destPath!)
//        .appendingPathComponent("countries.json")
//    let fullDestPathString = fullDestPath.path
//
//    if(filemgr.fileExists(atPath:fullDestPathString)) {
//        print("file available")
//        do {
//            //try filemgr.removeItem(atPath: fullDestPathString)
//            //try FileManager.default.copyItem(atPath: filePath!, toPath: fullDestPathString)
//            data = try Data(contentsOf: fullDestPath, options: .mappedIfSafe)
//
//        } catch {
//            print("Read failed:Existing")
//        }
//    } else {
//        do {
//            try FileManager.default.copyItem(atPath: filePath!, toPath: fullDestPathString)
//            data = try Data(contentsOf: fullDestPath, options: .mappedIfSafe)
//
//        } catch {
//            print("Read failed:Non Existing")
//        }
//
//    }
//    return data!
//}
