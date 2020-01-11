//
//  FoursquareClient.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import Foundation

class FoursquareClient: APIClient {
    
    var session: URLSession
    var venue = [Venues]()
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getVenues(with endpoint: FoursquareEnum , completion: @escaping (Result<FoursquareAPIResponse?, APIError>) -> Void) {
        
        fetch(with: endpoint.request.url!, decode: { (json) in
            guard let wholeResponse = json as? FoursquareAPIResponse else { return  nil }
            return wholeResponse
        }, completion: completion)
    }
    
    
    func getWholeVenues(with endpoint: FoursquareEnum , completion: @escaping (APIError) -> Void) {
        
        getVenues(with: endpoint)  { [weak self] result in
            switch result {
            case .success(let response):
                guard let response = response?.response.venues else { return }
                self?.venue.append(contentsOf: response)
                completion(.invalidData)
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    
    
}
