//
//  WeatherCell.swift
//  Weather
//
//  Created by Андрей Бучевский on 16.03.2022.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    var weatherViewModel: WeatherCellViewModel! {
        didSet {
            cityName.text = weatherViewModel.cityName
            weatherDescription.text = weatherViewModel.weatherDescription
            tempLabel.text = weatherViewModel.temperatureString
        }
    }
    
}
