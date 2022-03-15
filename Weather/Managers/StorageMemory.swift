//
//  StorageMemory.swift
//  Weather
//
//  Created by Андрей Бучевский on 16.03.2022.
//

import Foundation

class StorageMemory {
    func saveWeather(weather: WeatherCellViewModel) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(weather)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
            let defaults = UserDefaults.standard
            defaults.set(json, forKey: "weather")
            defaults.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getWeather() -> WeatherCellViewModel? {
        do {
            if (UserDefaults.standard.object(forKey: "weather") == nil) {
                return nil
            } else {
                let json = UserDefaults.standard.string(forKey: "weather") ?? "{}"
                let jsonDecoder = JSONDecoder()
                guard let jsonData = json.data(using: .utf8) else {
                    return nil
                }
                let weather: WeatherCellViewModel = try jsonDecoder.decode(WeatherCellViewModel.self, from: jsonData)
                return weather
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

