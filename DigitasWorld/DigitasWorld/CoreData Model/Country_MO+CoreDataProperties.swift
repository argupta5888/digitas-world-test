//
//  Country_MO+CoreDataProperties.swift
//  DigitasWorld
//
//  Created by ashok on 04/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Country_MO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country_MO> {
        return NSFetchRequest<Country_MO>(entityName: "Country_MO")
    }

    @NSManaged public var borders: NSObject?
    @NSManaged public var capital: String?
    @NSManaged public var currencies: NSObject?
    @NSManaged public var languages: NSObject?
    @NSManaged public var latlng: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var population: Int32
     @NSManaged public var region: String?

}
