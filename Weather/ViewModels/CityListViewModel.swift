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
    var storageManager = StorageManager()
    var tempUnit: TempUnit = .celsius
    var weatherViweMdel = WeatherViewModel()
    
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
    
    
        func didSelectRowAt(indexPath: IndexPath, isSearching: Bool) -> ((String, String), String) {
        if isSearching{
            return ((String(filteredSearchCities.value[indexPath.row].lat), String(filteredSearchCities.value[indexPath.row].lon)), tempUnit.rawValue)
        } else {
            return ((favouriteCities.value[indexPath.row].latString, favouriteCities.value[indexPath.row].lonString), tempUnit.rawValue)
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
    
    func saveData() {
        storageManager.saveCities(favouriteCities.value)
    }

    func loadData() {
        favouriteCities.value = storageManager.loadCity()
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


