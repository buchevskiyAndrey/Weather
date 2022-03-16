//
//  CityViewData.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

//Model to parse JSON file with cities
struct City: Decodable {
    let name: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}
