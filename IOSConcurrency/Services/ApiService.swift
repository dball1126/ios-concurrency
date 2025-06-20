//
//  ApiService.swift
//  IOSConcurrency
//
//  Created by Daniel Ball on 6/5/25.
//

import Foundation

struct ApiService {
    let urlString: String
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                completion: @escaping (Result<T,APIError>) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
            else {
                    completion(.failure(.invalidResponseStatus))
                    return
            }
            guard
                error == nil
            else {
                completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard
                let data = data
            else {
                completion(.failure(.corruptData))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
                print("Error")
            }
        }
        .resume()
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The endpoint url is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The APIO failed to issue a valid response.", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}
