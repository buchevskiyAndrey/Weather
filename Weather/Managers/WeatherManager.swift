//
//  WeatherManager.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

class WeatherManager {
    static let shared = WeatherManager()
    private init() {}
    
    
    func fetchWeather(latitude: String, longtitude: String, unit: String, completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\(apiKey)&units=\(unit)"
        guard let url = URL(string: urlString)
        else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        URLSession.shared.request(url: url, expecting: WeatherData.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let weatherData):
                let weather = CurrentWeather(weatherData: weatherData)
                completion(.success(weather))
            }
        }
    }
}
