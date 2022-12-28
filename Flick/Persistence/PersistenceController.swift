//
//  PersistenceController.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 27.12.2022.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Flicks")
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Container failed to load: \(error)")
            }
        }
    }
}
