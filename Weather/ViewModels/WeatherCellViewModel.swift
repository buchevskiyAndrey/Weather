//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation

class WeatherCellViewModel: Codable {
    let cityName: String
    let weatherDescription: String
    let systemIconNameString: String
    let temperatureString: String
    let tempMinString: String
    let tempMaxString: String
    let pressureLabel: String
    let humidityLabel: String
    let windSpeedString: String
    let windDirectionString: String
    let lonString: String
    let latString: String
    let metric: String
    
    init(cityName: String, weatherDescription: String, systemIconNameString: String, temperatureString: String, tempMinString: String, tempMaxString: String, pressureLabel: String, humidityLabel: String, windSpeedString: String, windDirectionString: String, lonString: String, latString: String, metric: String) {
        self.cityName = cityName
        self.weatherDescription = weatherDescription
        self.systemIconNameString = systemIconNameString
        self.temperatureString = temperatureString
        self.tempMinString = tempMinString
        self.tempMaxString = tempMaxString
        self.pressureLabel = pressureLabel
        self.humidityLabel = humidityLabel
        self.windSpeedString = windSpeedString
        self.windDirectionString = windDirectionString
        self.lonString = lonString
        self.latString = latString
        self.metric = metric
    }
}

