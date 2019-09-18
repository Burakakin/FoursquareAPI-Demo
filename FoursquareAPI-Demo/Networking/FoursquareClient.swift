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
    
    func getVenues(with endpoint: FoursquareEnum , completion: @escaping (Result<FoursquareAPIResponse?, APIError>) -> Void) {
        
        fetch(with: endpoint.request.url!, decode: { (json) in
            guard let wholeResponse = json as? FoursquareAPIResponse else { return  nil }
            return wholeResponse
        }, completion: completion)
        
        
    }
    
    
}
