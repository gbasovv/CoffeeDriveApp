//
//  DataFetcherService.swift
//  CoffeeDriveApp
//
//  Created by George on 20.09.21.
//

import Foundation

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    var localDataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher(), localDataFetcher: DataFetcher = LocalDataFetcher()) {
        self.networkDataFetcher = dataFetcher
        self.localDataFetcher = localDataFetcher
    }
    
    func fetchLocalMenu(completion: @escaping (MenuItems?) -> Void) {
        let localUrlString = "Menu.txt"
        localDataFetcher.fetchGenericJSONData(urlString: localUrlString, response: completion)
    }
    
    func fetchReviews(completion: @escaping (Results?) -> Void) {
        let urlString = "https://app.reviewapi.io/api/v1/reviews?apikey=097946f0-2514-11ec-8252-3787a35e0112&url=https://www.tripadvisor.com/Restaurant_Review-g295424-d21035606-Reviews-Asil_Restaurant-Dubai_Emirate_of_Dubai.html&amount=5"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
}
