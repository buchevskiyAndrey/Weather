//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation
import UIKit
import CoreLocation

class CityListViewModel: NSObject {
    //MARK: - Public properties
    var favouriteCities: Box<[WeatherCellViewModel]> = Box([])
    var filteredSearchCities: Box<[CityCellViewModel]> = Box([])
    var currentLocation: Box<(String, String)?> = Box(nil)
    
    //MARK: - Private properties
    private var cities: [CityCellViewModel] = []
    private var storageManager = StorageManager()
    private var tempUnit: TempUnit = .celsius
    
    
    //MARK: - Methods for building TableView
    func numberOfRowsInSection(isSearching: Bool) -> Int {
        if isSearching {
            return filteredSearchCities.value.count
        } else {
            return favouriteCities.value.count
        }
    }
    
    func titleForSearchingCell(atIndexPath indexPath: IndexPath) -> CityCellViewModel {
        return filteredSearchCities.value[indexPath.row]
        
    }
    
    func titleForFavouriteCell(atIndexPath indexPath: IndexPath) -> WeatherCellViewModel {
        return favouriteCities.value[indexPath.row]
    }
    
    func didSelectRowAtSearch(indexPath: IndexPath) -> ((String, String), String) {
        return ((String(filteredSearchCities.value[indexPath.row].lat), String(filteredSearchCities.value[indexPath.row].lon)), tempUnit.rawValue)
    }
    
    func didSelectRowAtFavourite(indexPath: IndexPath) -> (WeatherCellViewModel, String) {
        return (favouriteCities.value[indexPath.row], tempUnit.rawValue)
    }
    
    
    //MARK: - Public methods
    //Get list of cities for search
    func fetchCities(completion: (Error?) -> Void) {
        CitiesManager.shared.fetchCities(forName: "cityList") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cities):
                self.cities = cities?.compactMap({return CityCellViewModel(city: $0)}) ?? []
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    //Update favourite cities with fresh data
    func updateFavouriteCities(completion: @escaping (Error?) -> Void) {
        for (index, weatherCellViewModel) in favouriteCities.value.enumerated() {
            WeatherManager.shared.fetchWeather(latitude: weatherCellViewModel.latString, longtitude: weatherCellViewModel.lonString, unit: tempUnit.rawValue) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let weather):
                    self.favouriteCities.value[index] = WeatherCellViewModel(cityName: weather.cityName, weatherDescription: weather.weatherDescription, systemIconNameString: weather.systemIconNameString, temperatureString: weather.temperatureString, tempMinString: weather.tempMinString, tempMaxString: weather.tempMaxString, pressureLabel: weather.pressureLabel, humidityLabel: weather.humidityLabel, windSpeedString: weather.windSpeedString, windDirectionString: weather.windDirectionString, lonString: weather.lonString, latString: weather.latString)
                case .failure(let error):
                    completion(error)
                }
            }
        }
        //Update the storage
        saveFavouriteCities()
    }
    
    func search(for symbol: String) {
        filteredSearchCities.value = []
        if !symbol.isEmpty {
            filteredSearchCities.value = cities.filter { city in
                return city.city.lowercased().hasPrefix(symbol)
            }
        }
    }
    
    //Call after the segment controler is changed
    func changeTempUnit(tempUnit: TempUnit) {
        self.tempUnit = tempUnit
        updateFavouriteCities { error in
            print(error)
        }
    }
    
    func requestLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let self = self else {return}
            print(location.coordinate.longitude)
            self.currentLocation.value?.0 = "\(location.coordinate.latitude)"
            self.currentLocation.value?.1 = "\(location.coordinate.longitude)"
        }
    }
    
    //Manage the storage
    func loadData() {
        favouriteCities.value = storageManager.loadCity()
    }
    
    func save(viewModel: WeatherCellViewModel) {
        favouriteCities.value.append(viewModel)
        saveFavouriteCities()
    }
    
    //ЧЕКНУТЬ НУЖНО ЛИ
    func getCurrentTemperatureUnit() -> TempUnit.RawValue {
        return tempUnit.rawValue
    }
    
    
    //MARK: - Private methods
    //Save favourite cities with their weather
    private func saveFavouriteCities() {
        storageManager.saveCities(favouriteCities.value)
    }
}

