//
//  CountryDetailPresenter.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

protocol CountryDetailPresentable: Presentable {
    
}

protocol iCountryDetailPresenter: iPresenter {
    var view: CountryDetailPresentable? {get set}
}

class CountryDetailPresenter: iCountryDetailPresenter {
  
    weak var view: CountryDetailPresentable?
    var interactor: iCountryDetailInteractor!
    var router: CountryDetailRouter!
    
    required init(view: Presentable) {
        self.view = view as? CountryDetailPresentable
    }
    
    func initInteractor() {
        interactor = CountryDetailInteractor(presenter: self)
        router = CountryDetailRouter()
    }
}

extension CountryDetailPresenter : CountryDetailInteractable {

}
