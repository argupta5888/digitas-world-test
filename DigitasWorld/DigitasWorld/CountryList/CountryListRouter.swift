//
//  CountryListRouter.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import UIKit

protocol iCountryListRouter {
    func showCountryDetail(source: UINavigationController?, data: Country)
}

class CountryListRouter: iCountryListRouter {
    
    func showCountryDetail(source: UINavigationController?, data: Country) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CountryDetailVC") as CountryDetailVC
        detailVC.country = data
        source?.pushViewController(detailVC, animated: true)
    }
}
