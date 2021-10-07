//
//  NetworkDataFetcher.swift
//  CoffeeDriveApp
//
//  Created by George on 20.09.21.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking

    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    public func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        print(T.self)
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, data: data)
            response(decoded)
        }
    }

    public func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
