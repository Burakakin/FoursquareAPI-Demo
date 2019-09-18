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
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getVenues(with endpoint: FoursquareEnum, query: String, latitude: String, longitude: String, completion: @escaping (Result<FoursquareAPIResponse?, APIError>) -> Void) {
        
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = endpoint.base
        urlComponents.path = endpoint.path
        let queryItems = [URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"), URLQueryItem(name: "v", value: "20190507"), URLQueryItem(name: "intent", value: "browse"), URLQueryItem(name: "radius", value: "100000"), URLQueryItem(name: "query", value: query), URLQueryItem(name: "client_id", value: clientID), URLQueryItem(name: "client_secret", value: clientSecret)]
        urlComponents.queryItems = queryItems
        
        
        let url = URL(string: urlComponents.url!.absoluteString)!
        print(url)
        
        fetch(with: url, decode: { (json) in
            guard let wholeResponse = json as? FoursquareAPIResponse else { return  nil }
            return wholeResponse
        }, completion: completion)
        
        
    }
    
    
}
