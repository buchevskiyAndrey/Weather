//
//  CityViewData.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

struct City: Decodable {
    let name: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}
