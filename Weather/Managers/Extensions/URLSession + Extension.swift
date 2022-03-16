//
//  URLSession + Extension.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation

extension URLSession {
    func request<T: Decodable>(url: URL?,
                                expecting: T.Type,
                                completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidInput))
            return
        }
        let task = dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                guard let error = error else {
                    completion(.failure(NetworkError.invalidInput))
                    return
                }
                completion(.failure(error))
                return
            }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
