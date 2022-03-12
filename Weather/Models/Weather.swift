//
//  Weather.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import Foundation

// MARK: - Welcome
struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let description: String

}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

