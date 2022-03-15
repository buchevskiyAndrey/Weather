//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation

class WeatherViewModel {
    var weather: Box<WeatherCellViewModel?> = Box(nil)
    
    func fetchWeather(for city: String, completion: @escaping (Error?) -> Void) {
        WeatherManager.shared.fetchWeather(forRequestType: .cityName(city: city)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let weather):
                self.weather.value = WeatherCellViewModel(weatherData: weather)
            case .failure(let error):
                completion(error)
            }
        }
    }
    deinit {
        print("Deini view model")
    }
}
