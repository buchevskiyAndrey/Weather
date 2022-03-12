//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation


class WeatherCellViewModel {
    //MARK: - Private properties
    private let code: Int
    private let temperature, tempMin, tempMax: Double
    private let pressure: Int
    private let humidity: Int
    private let windSpeed: Double
    private let windDirection: Int
    
    //MARK: - Public properties
    let cityName: String
    let weatherDescription: String
    var systemIconNameString: String {
        switch code {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800:       return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default:
            return "nosign"
        }
    }

    var temperatureString: String {
        String(format: "%0.0f", temperature) + "\u{00B0}C"
    }
    

    var tempMinString: String {
        String(format: "%0.0f", tempMin) + "\u{00B0}C"
    }
    
    var tempMaxString: String {
        String(format: "%0.0f", tempMax) + "\u{00B0}C"
    }
    
    var pressureLabel: String {
        String(pressure) + " мм."
    }
    
    var humidityLabel: String {
        String(humidity) + "%"
    }
    
    
    var windSpeedString: String {
        String(format: "%0.0f", windSpeed)  + " м/с"
    }
    
    var windDirectionString: String {
        String(format: "%0.0f", windDirection) + "\u{00B0}C"
    }
    
    init(weatherData: CurrentWeather) {
        code = weatherData.weather.first!.id
        weatherDescription = weatherData.weather.first!.description
        cityName = weatherData.name
        temperature = weatherData.main.temp
        tempMin = weatherData.main.tempMin
        tempMax = weatherData.main.tempMax
        humidity = weatherData.main.humidity
        pressure = weatherData.main.pressure
        windSpeed = weatherData.wind.speed
        windDirection = weatherData.wind.deg
    }

}
