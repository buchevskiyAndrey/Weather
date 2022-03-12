//
//  CityCellViewModel.swift
//  Weather
//
//  Created by Андрей Бучевский on 11.03.2022.
//

import Foundation


class CityCellViewModel {
    let city: String
    
    init(city: City) {
            self.city = city.name
        }
}
