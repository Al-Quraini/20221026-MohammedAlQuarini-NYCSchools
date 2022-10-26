//
//  CodableBundleExtension.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import Foundation

import Foundation

extension Bundle {
  func decode<T: Codable>(_ file: String) throws -> T {
    // 1. Locate the json file
    guard let url = self.url(forResource: file, withExtension: nil) else {
        throw CodableBundleError.pathError
    }
    
    // 2. Create a property for the data
    guard let data = try? Data(contentsOf: url) else {
        throw CodableBundleError.loadError
    }
    
    // 3. Create a decoder
    let decoder = JSONDecoder()
    
    // 4. Create a property for the decoded data
    guard let loaded = try? decoder.decode(T.self, from: data) else {
        throw CodableBundleError.decodingError
    }
    
    // 5. Return the ready-to-use data
    return loaded
  }
}
