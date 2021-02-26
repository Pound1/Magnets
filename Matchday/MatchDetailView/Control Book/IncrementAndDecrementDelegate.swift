//
//  IncrementAndDecrementDelegate.swift
//  Matchday
//
//  Created by Lachy Pound on 25/2/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import Foundation

protocol IncrementAndDecrementDelegate {
    func increment(type: statisticType)
    func decrement(type: statisticType)
}
