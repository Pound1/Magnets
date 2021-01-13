//
//  matchStatus.swift
//  Matchday
//
//  Created by Lachy Pound on 13/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import Foundation

enum matchStatus: String, Codable {
    case notStarted = "Not started"
    case inProgress = "In progress"
    case complete = "Complete"
}

enum groundAdvantage: String, Codable {
    case home = "home"
    case away = "away"
    case mutual = "mutual"
}
