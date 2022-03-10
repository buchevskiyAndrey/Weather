//
//  CityCell.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityViewModel: CityViewModel! {
        didSet {
            cityNameLabel.text = cityViewModel.city
        }
    }
    
   
}

