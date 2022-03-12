//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

//protocol CityViewModelProtocol {
//}


class CityListViewModel {
    var cities: Box<[CityCellViewModel]> = Box([])
    
    func numberOfRowsInSection() -> Int {
        return cities.value.count
    }
    
    func titleForCell(atIndexPath indexPath: IndexPath) -> CityCellViewModel {
        return cities.value[indexPath.row]
    }
    
    func fetchCities(completion: (Error?) -> Void) {
        CityManager.shared.fetchCities(forName: "cityList") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let cities):
                self.cities.value = cities?.compactMap({return CityCellViewModel(city: $0)}) ?? []
            case .failure(let error):
                completion(error)
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
