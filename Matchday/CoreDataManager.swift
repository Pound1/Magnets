//
//  CoreDataManager.swift
//  Matchday
//
//  Created by Lachy Pound on 30/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MatchdayModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Failed to load store data: \(err)")
            }
        }
        return container
    }()
}
