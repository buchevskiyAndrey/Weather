//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation


class CityListViewModel {
    
    
    var filteredCities: Box<[CityCellViewModel]> = Box([])
    private var cities: [CityCellViewModel] = []
    
    func numberOfRowsInSection() -> Int {
        return filteredCities.value.count
    }
    
    func titleForCell(atIndexPath indexPath: IndexPath) -> CityCellViewModel {
        return filteredCities.value[indexPath.row]
    }
    
    func didSelectRowAt(atIndexPath indexPath: IndexPath) -> String {
        return filteredCities.value[indexPath.row].city
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
    
    func search(for symbol: String) {
        filteredCities.value = []
        if !symbol.isEmpty {
            filteredCities.value = cities.filter { city in
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

