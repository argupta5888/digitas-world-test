//
//  Country.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

struct Country : Codable {
    
    let name : String?
    let capital : String?
    let population : Int?
    let latlng : [Double]?
    let borders : [String]?
    let languages : [String]?
    let currencies : [String]?
    let region : String?

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
}
