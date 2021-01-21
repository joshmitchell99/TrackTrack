//
//  Student.swift
//  TrackTrack1
//
//  Created by Josh Mitchell on 1/21/21.
//

import Foundation

struct Jumper: Codable {
    var name = ""
    var jumps = [Float]()
    
    init(name: String, jumps: [Float]) {
        self.name = name
        self.jumps = jumps
    }
}
