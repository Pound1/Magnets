//
//  StubPlayer.swift
//  Matchday
//
//  Created by Lachy Pound on 27/3/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation

class StubPlayer: Player {
    
    convenience init(name: String = "", number: Int) {
        self.init()
        self.stubbedName = name
    }
    
    var stubbedName: String = ""
    var stubbedNumber: Int = 3
}
