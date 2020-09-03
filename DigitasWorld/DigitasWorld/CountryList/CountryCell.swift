//
//  CountryCell.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import UIKit


class CountryCell: UITableViewCell {

    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var country: Country? {
        didSet {
            lblName.text = country?.name
            lblCapital.text = country?.capital
            lblPopulation.text = country?.population?.toString
            lblCurrency.text = country?.currencies?.toString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
