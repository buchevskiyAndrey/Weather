//
//  Weather.swift
//  Weather
//
//  Created by Андрей Бучевский on 16.03.2022.
//

import Foundation

//Model for converting WeatherData to String to save in UserDefaults and pass to WeaherCellViewModel
struct CurrentWeather {
    //MARK: - Private properties
    private let code: Int
    private let temperature, tempMin, tempMax: Double
    private let pressure: Int
    private let humidity: Int
    private let windSpeed: Double
    private let windDirection: Int
    private let lon: Double
    private let lat: Double
    
//    private var tempUnit: TempUnit
    
    //MARK: - Public properties
    var cityName: String
    var weatherDescription: String
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
        String(format: "%0.0f", temperature)
    }
    
    var tempMinString: String {
        String(format: "%0.0f", tempMin)
    }
    
    var tempMaxString: String {
        String(format: "%0.0f", tempMax)
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
        String(format: "%0.0f", windDirection) + "\u{00B0}"
    }
    
    var lonString: String {
        String(lon)
    }
    
    var latString: String {
        String(lat)
    }
    
    init(weatherData: WeatherData) {
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
        lon = weatherData.coord.lon
        lat = weatherData.coord.lat
    }
}
