//
//  MainViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

//protocol CityViewModelProtocol {
//}

class CityViewModel {
    let city: String

    //Dependency Injection
    init(city: City) {
        self.city = city.name
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
