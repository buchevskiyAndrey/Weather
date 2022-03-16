//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation

protocol ReturnViewModelProtocol: AnyObject {
    func transferViewModel(_ importer: WeatherViewModel, viewModel: WeatherCellViewModel)
}



class WeatherViewModel {
    weak var delegate: ReturnViewModelProtocol?
    var weather: Box<WeatherCellViewModel?> = Box(nil)
    var tempUnit: String = ""
    
    func fetchWeather(for coordinates: (String, String), unit: String, completion: @escaping (Error?) -> Void) {
        tempUnit = unit
        WeatherManager.shared.fetchWeather(latitude: coordinates.0, longtitude: coordinates.1, unit: unit) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let weather):
                self.weather.value = WeatherCellViewModel(cityName: weather.cityName, weatherDescription: weather.weatherDescription, systemIconNameString: weather.systemIconNameString, temperatureString: weather.temperatureString, tempMinString: weather.tempMinString, tempMaxString: weather.tempMaxString, pressureLabel: weather.pressureLabel, humidityLabel: weather.humidityLabel, windSpeedString: weather.windSpeedString, windDirectionString: weather.windDirectionString, lonString: weather.lonString, latString: weather.latString)
            case .failure(let error):
                completion(error)
            }
        }
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
    
    func save() {
        guard let viewModel = weather.value else {return}
        delegate?.transferViewModel(self, viewModel: viewModel)
    }
    

}
