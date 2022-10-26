//
//  NetworkError.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad url"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
