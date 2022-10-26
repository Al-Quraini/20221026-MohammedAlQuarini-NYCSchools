//
//  NetworkManager.swift
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func performRequest<T : Codable>(_ model : T.Type, from url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkManager : NetworkManagerProtocol {
    func performRequest<T : Codable>(_ model : T.Type, from url: String, completion: @escaping (Result<T, NetworkError>) -> Void)   {
        // 1. Create a url
        guard let url = URL(string: url)
        else {
            completion(.failure(.badURL))
                       return
        }
        // 2. Create a url session
        let session = URLSession(configuration: .default)
        // 3. Give the session a task
        let task = session.dataTask(with: url) { data , response, error in
            if let error = error {
                completion(.failure(.other(error)))
                       return
                   }
        //4. Create a property for the decoded data
        if let safeData = data {
                do {
                    let response = try JSONDecoder().decode(model, from: safeData)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.other(error)))
                }
            }
        }
        //5. Resume the task
        task.resume()
    }
}
