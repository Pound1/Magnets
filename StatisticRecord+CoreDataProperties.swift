//
//  StatisticRecord+CoreDataProperties.swift
//  Matchday
//
//  Created by Lachy Pound on 22/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//
//

import Foundation
import CoreData


extension StatisticRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticRecord> {
        return NSFetchRequest<StatisticRecord>(entityName: "StatisticRecord")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var label: String?

}
