//
//  StorageMemory.swift
//  Weather
//
//  Created by Андрей Бучевский on 16.03.2022.
//

import Foundation

//protocol StorageProtocol {
//    func loadCity() -> [WeatherCellViewModel]
//    func saveCities(_ cities: [WeatherCellViewModel])
//}
//
//
//class StorageMemory: StorageProtocol{
//    
//    
//    private var storage = UserDefaults.standard
//    var storageKey: String = "weather"
//    private enum WeatherKey: String {
//        case cityName
//        case weatherDescription
//        case systemIconNameString
//        case temperatureString
//        case tempMinString
//        case tempMaxString
//        case pressureLabel
//        case humidityLabel
//        case windSpeedString
//        case windDirectionString
//    }
//
////    func loadCity() -> [WeatherCellViewModel] {
////        var resultCities: [WeatherCellViewModel] = []
////        let citiesFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
////        for city in citiesFromStorage {
////            guard let cityName = city[WeatherKey.cityName.rawValue],
////                  let weatherDescription = city[WeatherKey.weatherDescription.rawValue],
////                  let systemIconNameString = city[WeatherKey.systemIconNameString.rawValue],
////                  let temperatureString = city[WeatherKey.temperatureString.rawValue],
////                  let tempMinString = city[WeatherKey.tempMinString.rawValue],
////                  let tempMaxString = city[WeatherKey.tempMaxString.rawValue],
////                  let pressureLabel = city[WeatherKey.pressureLabel.rawValue],
////                  let humidityLabel = city[WeatherKey.humidityLabel.rawValue],
////                  let windSpeedString = city[WeatherKey.windSpeedString.rawValue],
////                  let windDirectionString = city[WeatherKey.windDirectionString.rawValue] else {
////                continue
////            }
////            resultCities.append(We)
////        }
////        return resultTasks
////    }
//    
//  
//
//    func saveCities(_ cities: [WeatherCellViewModel]) {
//        var arrayForStorage: [[String:String]] = []
//        cities.forEach{ city in
//            var newElementForStorage: Dictionary<String, String> = [:]
//            newElementForStorage[WeatherKey.cityName.rawValue] = city.cityName
//            newElementForStorage[WeatherKey.weatherDescription.rawValue] = city.weatherDescription
//            newElementForStorage[WeatherKey.systemIconNameString.rawValue] = city.systemIconNameString
//            newElementForStorage[WeatherKey.temperatureString.rawValue] = city.temperatureString
//            newElementForStorage[WeatherKey.tempMinString.rawValue] = city.tempMinString
//            newElementForStorage[WeatherKey.tempMaxString.rawValue] = city.tempMaxString
//            newElementForStorage[WeatherKey.pressureLabel.rawValue] = city.pressureLabel
//            newElementForStorage[WeatherKey.humidityLabel.rawValue] = city.humidityLabel
//            newElementForStorage[WeatherKey.windSpeedString.rawValue] = city.windSpeedString
//            newElementForStorage[WeatherKey.windDirectionString.rawValue] = city.windDirectionString
//            arrayForStorage.append(newElementForStorage)
//        }
//        storage.set(arrayForStorage, forKey: storageKey)
//    }
//
//
//
//}

