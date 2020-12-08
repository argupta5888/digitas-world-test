//
//  Country.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import CoreData

protocol Storable {
     func toCoreData(coreData: NSManagedObject)
}

struct Country : Codable, Storable {
    
    var name : String?
    var capital : String?
    var population : Int?
    var latlng : [Double]?
    var borders : [String]?
    var languages : [String]?
    var currencies : [String]?
    var region : String?
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case capital = "capital"
        case population = "population"
        case latlng = "latlng"
        case borders = "borders"
        case languages = "languages"
        case currencies = "currencies"
        case region = "region"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        latlng = try values.decodeIfPresent([Double].self, forKey: .latlng)
        borders = try values.decodeIfPresent([String].self, forKey: .borders)
        languages = try values.decodeIfPresent([String].self, forKey: .languages)
        currencies = try values.decodeIfPresent([String].self, forKey: .currencies)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        
    }
    
    var latitute: Double?  {
        get {
            return latlng?[0]
        }
    }
    
    var longitude: Double? {
        get {
            return latlng?[1]
        }
    }
    
    func toCoreData(coreData: NSManagedObject) {
        guard let coreData = coreData as? Country_MO else {return}
        
        coreData.name = self.name
        coreData.capital = self.capital
        coreData.borders = self.borders as NSObject?
        coreData.currencies = self.currencies as NSObject?
        coreData.languages = self.languages as NSObject?
        coreData.latlng = self.latlng as NSObject?
        coreData.population = Int32(self.population ?? 0)
        coreData.region = self.region ?? ""
    }
    
//    mutating func coreDataToModel(coreData: NSManagedObject) {
//        guard let coreData = coreData as? Country_MO else {return}
//
//        self.name = coreData.name
//        self.capital = coreData.capital
//        self.borders = coreData.borders as? [String]
//        self.currencies = coreData.currencies as? [String]
//        self.languages = coreData.languages as? [String]
//        self.latlng = coreData.latlng as? [Double]
//        self.population = Int(coreData.population)
//        self.region = coreData.region
//    }
}

