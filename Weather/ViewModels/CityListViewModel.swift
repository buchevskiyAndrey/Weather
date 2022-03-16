//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation
import UIKit

class CityListViewModel {
    //MARK: - Public properties
    var favouriteCities: Box<[WeatherCellViewModel]> = Box([])
    var filteredSearchCities: Box<[CityCellViewModel]> = Box([])
    
    var tempUnit: TempUnit = .celsius
    
    //MARK: - Private properties
    private var cities: [CityCellViewModel] = []
    
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
    
    
        func didSelectRowAt(indexPath: IndexPath, isSearching: Bool) -> ((Double, Double), String) {
        if isSearching{
            return ((filteredSearchCities.value[indexPath.row].lat, filteredSearchCities.value[indexPath.row].lon), tempUnit.rawValue)
        } else {
            return ((favouriteCities.value[indexPath.row].lat, favouriteCities.value[indexPath.row].lon), tempUnit.rawValue)
        }
    }
    
    
    //MARK: - Public methods
    func fetchCities(completion: (Error?) -> Void) {
        CityManager.shared.fetchCities(forName: "cityList") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cities):
                self.cities = cities?.compactMap({return CityCellViewModel(city: $0)}) ?? []
            case .failure(let error):
                completion(error)
                }
            }
        }
    
    func loadData() {
        favouriteCities.value.append(WeatherCellViewModel(weatherData: CurrentWeather(coord: Coordinate(lon: 12, lat: 12), weather: [Weather(id: 12, description: "S")], main: Main(temp: 12, tempMin: 21, tempMax: 12, pressure: 12, humidity: 12), wind: Wind(speed: 12, deg: 12), name: "fds")))
    }
    
    func search(for symbol: String) {
        filteredSearchCities.value = []
        if !symbol.isEmpty {
            filteredSearchCities.value = cities.filter { city in
                return city.city.lowercased().hasPrefix(symbol)
            }
        }
    }
    
    func changeTempUnit(tempUnit: TempUnit) {
        self.tempUnit = tempUnit
    }
    
}

