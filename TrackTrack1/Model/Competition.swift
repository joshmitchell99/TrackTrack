//
//  Competition.swift
//  TrackTrack1
//
//  Created by Josh Mitchell on 1/21/21.
//

import Foundation

struct Competition: Codable {
    var name = "name"
    var jumpers = [Jumper]()
    
    init(name: String, jumpers: [Jumper]) {
        self.name = name
        self.jumpers = [Jumper(name: "test", jumps: [0])]
    }
}
