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
    func fetchALLCountryLocally() throws
}

class CountryListInteractor: iCountryListInteractor {
   
    weak var presenter: CountryListInteractable?
    
    required init(presenter: CountryListInteractable) {
        self.presenter = presenter
    }
    
    func fetchAllCountry() {
        
        RemoteClient.request(of: Country.self, target: ResourceType.all, success: { [weak self] result in
            guard let ws = self else {return}
            switch result {
            case .success(let data):
                ws.writeToLocalStorage(list: data)
            case .failure(let error):
                ws.presenter?.didFailFetchingData(error: error)
            }
            }, error: { [weak self] error in
                guard let ws = self else {return}
                ws.presenter?.didFailFetchingData(error: error)
        }) {  [weak self]error in
            guard let ws = self else {return}
            ws.presenter?.didFailFetchingData(error: error)
        }
    }
    
    private func writeToLocalStorage(list: [Country]) {
        
        do {
            if (try CoreDataHelper.deleteAllFrom(entityName: "Country_MO"))  {
                
                try CoreDataHelper.saveRecord(entity: Country_MO.self, list: list)
                presenter?.didFinishFetchingData(list: list)
            }
        }
        catch
            CustomError.DatabaseError {
                presenter?.didFailFetchingData(error: CustomError.DatabaseError)
        }
        catch let err {
            presenter?.didFailFetchingData(error: CustomError.HTTPError(err: err))
        }
    }
    
    func fetchALLCountryLocally() throws {
        do {
           let result =  try CoreDataHelper.selectAllFrom(entity: "Country_MO") as [Country_MO]
            var countries: [Country] = []
            result.forEach { coreData in
                var country = Country()
                country.coreDataToModel(coreData: coreData)
                countries.append(country)
            }
            presenter?.didFinishFetchingData(list: countries)
        }
        catch
            CustomError.DatabaseError {
                throw CustomError.DatabaseError
        }
    }
}

