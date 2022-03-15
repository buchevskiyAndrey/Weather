//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation


class CityListViewModel {
    
  
//
    //Search Controller is off
//    var favouriteCities: Box<[Cell]> = Box([])
        var favouriteCities: Box<[CityCellViewModel]> = Box([])

    //Search Controller is active
    var filteredSearchCities: Box<[CityCellViewModel]> = Box([])
    private var cities: [CityCellViewModel] = []
    
    
    func numberOfRowsInSection(isSearching: Bool) -> Int {
        if isSearching {
            return filteredSearchCities.value.count
        } else {
            return favouriteCities.value.count
        }
       
    }
    
    func titleForCell(atIndexPath indexPath: IndexPath, isSearching: Bool) -> CityCellViewModel {
        if isSearching {
            return filteredSearchCities.value[indexPath.row]
        } else {
            return favouriteCities.value[indexPath.row]
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath, isSearching: Bool) -> String {
        if isSearching{
            return filteredSearchCities.value[indexPath.row].city
        } else {
            return favouriteCities.value[indexPath.row].city
        }
    }
    
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
        favouriteCities.value.append(CityCellViewModel(city: City(name: "Hello", coord: Coord(lon: 12, lat: 12))))
    }
    
    func search(for symbol: String) {
        filteredSearchCities.value = []
        if !symbol.isEmpty {
            filteredSearchCities.value = cities.filter { city in
                return city.city.lowercased().hasPrefix(symbol)
            }
        }
    }
}


//protocol TableViewViewModelProtocol {
//    var updateViewData: ((ViewData) -> ())? {get set}
//    func startFetch()
//}
//
//final class TableViewViewModel: TableViewViewModelProtocol {
//    public var updateViewData: ((ViewData) -> ())?
//
//    init() {
//        updateViewData?(.initial)
//    }
//
//
//    public func startFetch() {
//
//        updateViewData?(.loading(ViewData.WeatherData()))
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let self = self else { return }
//            self.updateViewData?(.success(ViewData.WeatherData()))
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
//            guard let self = self else { return }
//            self.updateViewData?(.failure(ViewData.WeatherData()))
//        }
//
//
//    }
//}
//

