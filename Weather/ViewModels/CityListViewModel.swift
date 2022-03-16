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
    var storageManager = StorageManager()
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
    
    func didSelectRowAtSearch(indexPath: IndexPath) -> ((String, String), String) {
        return ((String(filteredSearchCities.value[indexPath.row].lat), String(filteredSearchCities.value[indexPath.row].lon)), tempUnit.rawValue)
    }
    
    func didSelectRowAtFavourite(indexPath: IndexPath) -> (WeatherCellViewModel, String) {
        return (favouriteCities.value[indexPath.row], tempUnit.rawValue)
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
    
    func save(viewModel: WeatherCellViewModel) {
        favouriteCities.value.append(viewModel)
        saveData()
    }
    
    func requestLocation() {
        LocationManager.shared.getUserLocation { [weak self] location in
            guard let self = self else {return}
            print(location.coordinate.longitude)
            self.currentLocation.value?.0 = "\(location.coordinate.latitude)"
            self.currentLocation.value?.1 = "\(location.coordinate.longitude)"
        }
    }


//    func getCurrentLocation() -> ((String, String), String) {
//        print(currentLocation)
////        return (currentLocation, tempUnit.rawValue)
//    }
}

