//
//  RotationDataModel.swift
//  Matchday
//
//  Created by Lachy Pound on 19/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

struct RotationData {
    var player: Player
    var position: String
    var timeStartedOnField: Date              
    var timeIntervalSinceStartingOnField: Int = 0
}
