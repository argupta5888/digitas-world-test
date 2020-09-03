//
//  CountryListInteractor.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

protocol CountryListInteractable: AnyObject {
    func didFinishFetchingData(list: [Country])
    func didFailFetchingData(error: CustomError)
}

protocol iCountryListInteractor {
    init(presenter: CountryListInteractable)
    var  presenter: CountryListInteractable? {get set}
    func fetchAllCountry()
}

class CountryListInteractor: iCountryListInteractor {
   
    weak var presenter: CountryListInteractable?
    
    required init(presenter: CountryListInteractable) {
        self.presenter = presenter
    }
    
    func fetchAllCountry() {
        
        RemoteClient.request(of: Country.self, target: ResourceType.all, success: { result in
            
            switch result {
            case .success(let data):
                self.presenter?.didFinishFetchingData(list: data)
            case .failure(let error):
                self.presenter?.didFailFetchingData(error: error)
            }
            
        }, error: { [weak self] error in
            guard let ws = self else {return}
            ws.presenter?.didFailFetchingData(error: error)
        }) {  [weak self]error in
            guard let ws = self else {return}
            ws.presenter?.didFailFetchingData(error: error)
        }
    }
}

