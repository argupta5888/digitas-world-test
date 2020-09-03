//
//  CountryDetailVC.swift
//  DigitasWorld
//
//  Created by ashok on 03/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController {
    
    var country: Country!
    
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblBorders: UILabel!
    @IBOutlet weak var lblLanguages: UILabel!
    
    var presenter: iCountryDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLatitude.text = country.latitute?.toString
        lblLongitude.text = country.longitude?.toString
        lblBorders.text = country.borders?.toString ?? "-"
        lblLanguages.text = country.languages?.toString
        
        presenter = CountryDetailPresenter(view: self)
        presenter.initInteractor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = country.name
    }
}

extension CountryDetailVC : CountryDetailPresentable {
    func willLoadData() {
    }
    
    func didLoadData() {
    }

    func didFail(error: CustomError) {
    }
}
