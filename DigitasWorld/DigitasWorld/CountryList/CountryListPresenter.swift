//
//  CountryListPresenter.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import UIKit

protocol CountryListPresentable: Presentable {
    
}

protocol iCountryListPresenter: iPresenter {
    var view: CountryListPresentable? {get set}
    func getCountryList() 
    var countries: [Country] {get set}
    func showDetail(for country: Country, source: UINavigationController?)
}

class CountryListPresenter: iCountryListPresenter {
    
    var countries: [Country] = []
    weak var view: CountryListPresentable? 
    var interactor: iCountryListInteractor!
    var router: CountryListRouter!
    
    required init(view: Presentable) {
        self.view = view as? CountryListPresentable
    }
    
    func initInteractor() {
        interactor = CountryListInteractor(presenter: self)
        router = CountryListRouter()
    }
    
    func getCountryList()  {
        view?.willLoadData()
        if (NetworkManager.sharedInstance.reachability.connection == .unavailable) {
            do {
                try interactor.fetchALLCountryLocally()
            }
            catch
                CustomError.DatabaseError {
                    view?.didFail(error: CustomError.DatabaseError)
                    
            }
            catch let err {
                view?.didFail(error: CustomError.HTTPError(err: err))
            }
        }
        else {
            interactor.fetchAllCountry()
        }
    }
    
    func showDetail(for country: Country, source: UINavigationController?) {
        router.showCountryDetail(source: source, data: country)
    }
}


extension CountryListPresenter: CountryListInteractable {
    func didFinishFetchingData(list: [Country]) {
        countries = list
        view?.didLoadData()
    }
    
    func didFailFetchingData(error: CustomError) {
        view?.didFail(error: error)
    }
}
