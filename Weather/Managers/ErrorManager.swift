//
//  ErrorManager.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case invalidInput
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Check your connection", comment: "Poor connection")
        case .invalidInput:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
