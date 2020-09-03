//
//  CountryDetailInteractor.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

protocol CountryDetailInteractable: AnyObject {
    
}

protocol iCountryDetailInteractor {
    init(presenter: CountryDetailInteractable)
    var  presenter: CountryDetailInteractable? {get set}
}

class CountryDetailInteractor: iCountryDetailInteractor {
   
    weak var presenter: CountryDetailInteractable?
    
    required init(presenter: CountryDetailInteractable) {
        self.presenter = presenter
    }
}
