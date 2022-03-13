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
    
    enum RequestType {
        case cityName(city: String)
        case coordinate
//        case coordinate(latitude: CLLocationDegrees, longtitude: CLLocationDegrees)
    }
    
    func fetchWeather(forRequestType requestType: RequestType, completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            let selectedSymbol = city.split(separator: " ").joined(separator: "%20")
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(selectedSymbol)&apikey=\(apiKey)&units=metric"
        case .coordinate:
//        case .coordinate(let latitude, let longtitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=LAT&lon=LON&appid=\(apiKey)&units=metric"
        }
        
        guard let url = URL(string: urlString)
        else {
            completion(.failure(NetworkError.badRequest))
            return
        }
        
        URLSession.shared.request(url: url, expecting: CurrentWeather.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let weather):
                completion(.success(weather))
            }
        }
    }
}
