//
//  Flick+CoreDataProperties.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 27.12.2022.
//
//

import Foundation
import CoreData


extension Flick {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flick> {
        return NSFetchRequest<Flick>(entityName: "Flick")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var plot: String?
    @NSManaged public var poster: String?
    @NSManaged public var rating: String?

}

extension Flick : Identifiable {

}
