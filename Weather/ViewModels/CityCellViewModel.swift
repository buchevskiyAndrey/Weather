//
//  CityCellViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 11.03.2022.
//

import Foundation

class CityCellViewModel {
    let city: String
    let lon: Double
    let lat: Double
    
    init(city: City) {
        self.city = city.name
        self.lat = city.coord.lat
        self.lon = city.coord.lon
    }
}
