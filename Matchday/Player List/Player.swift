//
//  Player.swift
//  Matchday
//
//  Created by Lachy Pound on 24/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import Foundation

//struct Player: Equatable {
//    let name: String
//    let number: Int
////    var position: PositionOnField
//
////     this overrides the native init function, allowing one or more fields to be optional.
////    init(name: String, number: Int, position: PositionOnField) {
////        self.name = name
////        self.number = number
////        self.position = position//PositionOnField.Bench
////    }
//}

enum PositionOnField: String, Decodable {
    case Forward = "Forward Line"
    case Back = "Backline"
    case Midfield
    case Bench
    case Listed
}


