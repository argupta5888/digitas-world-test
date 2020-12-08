//
//  Country_MO+CoreDataClass.swift
//  DigitasWorld
//
//  Created by ashok on 04/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Country_MO)
public class Country_MO: NSManagedObject {

    func toModel() -> Country {
        var country = Country()
        country.name = name
        country.capital = capital
        country.borders = borders as? [String]
        country.currencies = currencies as? [String]
        country.languages = languages as? [String]
        country.latlng = latlng as? [Double]
        country.population = Int(population)
        country.region = region
        
        return country
    }
}
