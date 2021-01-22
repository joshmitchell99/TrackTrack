//
//  Brain.swift
//  TrackTrack1
//
//  Created by Edward Raven on 21/01/2021.
//

import UIKit

struct Brain {
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Competitions.plist")
    
    mutating func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(V.competitions)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error catching the encoded array, \(error)")
        }
    }
    
    mutating func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                V.competitions = try decoder.decode([Competition].self, from: data)
            } catch {
                print("Error catching the decoding, \(error)")
            }
        }
    }
        
}

//var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Competitions.plist")
//
//// saves the array to the plist
//func saveItems(vToBeStored: V) {
//    let encoder = PropertyListEncoder()
//    do {
//        let data = try encoder.encode(vToBeStored)
//        try data.write(to: dataFilePath!)
//    } catch {
//        print("Error catching the encoded array, \(error)")
//    }
//}
//
//// loads the data from the plist
//func loadItems() -> V {
//    if let data = try? Data(contentsOf: dataFilePath!) {
//        let decoder = PropertyListDecoder()
//        do {
//            let vFromStorage = try decoder.decode(V.self, from: data)
//            return vFromStorage
//        } catch {
//            print("Error catching the decoding, \(error)")
//        }
//    }
//    let vFromStorage = V()
//    return vFromStorage
//}
