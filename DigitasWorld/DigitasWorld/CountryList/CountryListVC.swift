//
//  CountryListVC.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import UIKit
import os

class CountryListVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let kCountryCell = "CountryCell"
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var presenter: iCountryListPresenter!
    private var filteredCountries: [Country] = []
    
    lazy var refereshControl: UIRefreshControl = {
        let refershControl = UIRefreshControl()
        refershControl.addTarget(self, action: #selector(updateList(_:)), for: .valueChanged)
        return refershControl
    }()
    
    private var isSearchBarEmpty : Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib(nibName: kCountryCell, bundle: nil), forCellReuseIdentifier: kCountryCell)
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.rowHeight = 60
        tblView.addSubview(refereshControl)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        presenter = CountryListPresenter(view: self)
        presenter.initInteractor()
        presenter.getCountryList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func filterSearchText(text: String) {
        filteredCountries = presenter.countries.filter { country -> Bool in
            return (country.region?.lowercased().contains(text.lowercased()) ?? false)
        }
        tblView.reloadData()
    }
    
    @objc func updateList(_ control: UIRefreshControl) {
     
     if !(NetworkManager.sharedInstance.reachability.connection == .unavailable) && presenter.countries.count == 0 {
         presenter.getCountryList()
     }
     else {
         if isFiltering {
             searchController.searchBar.text = nil
             filteredCountries = presenter.countries
             tblView.reloadData()
         }
     }
         refereshControl.endRefreshing()
     }
}

extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isFiltering ? filteredCountries.count : presenter.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCountryCell) as! CountryCell
        
        cell.country =  isFiltering ? filteredCountries[indexPath.row] : presenter.countries[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = isFiltering ? filteredCountries[indexPath.row] : presenter.countries[indexPath.row]
        presenter.showDetail(for:selectedCountry, source: self.navigationController)
    }
}

extension CountryListVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterSearchText(text: searchBar.text!)
    }
}

extension CountryListVC : CountryListPresentable {
    func willLoadData() {
        activityIndicator.startAnimating()
    }
    
    func didLoadData() {
        activityIndicator.stopAnimating()
        filteredCountries = presenter.countries
        tblView.reloadData()
        os_log("Reloading table with complete data", log:Log.table)
    }
    
    func didFail(error: CustomError) {
         activityIndicator.stopAnimating()
        showError(msg: error.localizedDescription)
    }
}
