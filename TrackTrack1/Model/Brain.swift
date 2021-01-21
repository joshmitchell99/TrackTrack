//
//  Brain.swift
//  TrackTrack1
//
//  Created by Edward Raven on 21/01/2021.
//

import Foundation
import UIKit

struct Brain: Codable {
    
    // data file path
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Competitions.plist")
    
    // saves the array to the plist
    func saveItems(competitonsArray: [V]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(competitonsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error catching the encoded array, \(error)")
        }
    }
    
    // loads the data from the plist
    func loadItems() -> [V] {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                let competitionArray = try decoder.decode([V].self, from: data)
                return competitionArray
            } catch {
                print("Error catching the decding, \(error)")
            }
        }
        let competitonArray = [V]()
        return competitonArray
    }
    
    func test() {
        print(dataFilePath!)
    }
    
    
    
}
