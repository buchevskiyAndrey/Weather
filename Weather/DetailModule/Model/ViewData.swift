//
//  ViewData.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

enum ViewData {
    case initial
    case loading(WeatherData)
    case success(WeatherData)
    case failure(WeatherData)
    
    
    struct WeatherData {
        
    }
    
}


