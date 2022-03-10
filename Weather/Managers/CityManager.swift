//
//  JSONManager.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

class CityManager {
    static let shared = CityManager()
    
    private init() {}
    
    
    func fetchCities(forName name: String, completion: (Result<[City]?, Error>) -> Void) {
        let localData = readLocalFile(forName: name)
        
        switch localData {
        case .failure(let error):
            completion(.failure(error))
        case .success(let localData):
            guard let localData = localData else {
                completion(.failure(NetworkError.unknown))
                return
            }
            let citiesData = parse(jsonData: localData)
            switch citiesData {
            case .failure(let error):
                completion(.failure(error))
            case .success(let cities):
                completion(.success(cities))
            }
        }
    }
    
    private func readLocalFile(forName name: String) -> Result<Data?, Error> {
        guard let sourceURL = Bundle.main.url(forResource: name, withExtension: "json") else {
            return .failure(NetworkError.unknown)
        }
        do {
            let jsonData = try Data(contentsOf: sourceURL)
            return .success(jsonData)
        } catch {
            return .failure(error)
        }
    }

    
    private func parse(jsonData: Data) -> Result<[City]?, Error> {
        do {
            let decodedData = try JSONDecoder().decode([City].self, from: jsonData)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}


