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
    
//    enum RequestType {
//        case cityName(city: String)
//        case coordinate
////        case coordinate(latitude: CLLocationDegrees, longtitude: CLLocationDegrees)
//    }
    
    func fetchWeather(latitude: Double, longtitude: Double, unit: String, completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\(apiKey)&units=\(unit)"
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
