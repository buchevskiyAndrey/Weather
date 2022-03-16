//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation

class WeatherViewModel {
    var weather: Box<WeatherCellViewModel?> = Box(nil)
    var tempUnit: String = ""
    
    func fetchWeather(for coordinates: (Double, Double), unit: String, completion: @escaping (Error?) -> Void) {
        tempUnit = unit
        WeatherManager.shared.fetchWeather(latitude: coordinates.0, longtitude: coordinates.1, unit: unit) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let weather):
                self.weather.value = WeatherCellViewModel(weatherData: weather)
            case .failure(let error):
                completion(error)
            }
        }
            }
    
    func save() {
//        guard let weather = weather.value else { return }
//        storage.saveWeather(weather: weather)
    }
    
    
    func returnTempUnit() -> String {
        var result = ""
        if tempUnit == TempUnit.celsius.rawValue {
            result = "°С"
        } else if tempUnit == TempUnit.fahrenheit.rawValue {
            result = "°F"
        }
        return result
    }
    
    deinit {
        print("Deini view model")
    }
}
