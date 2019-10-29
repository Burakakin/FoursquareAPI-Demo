//
//  Endpoint.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import Foundation

let clientID = "M1VIFMYUHYDWPKUTHDEUYBTX4O0P4NAORLMYAJJ4W1LF15KJ"
let clientSecret = "LGPJX5TU1MTFBBUFMMHPXVSQQ4LBLPAXB1NA0RCU1WHCDFPD"

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = base
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

//https://api.foursquare.com/v2/venues/5642aef9498e51025cf4a7a5?client_id=M1VIFMYUHYDWPKUTHDEUYBTX4O0P4NAORLMYAJJ4W1LF15KJ&client_secret=LGPJX5TU1MTFBBUFMMHPXVSQQ4LBLPAXB1NA0RCU1WHCDFPD&v=20180522

enum FoursquareEnum {
    case search(lattitude: String, longitude: String, query: String)
    case venueDetail(venueID: String)
}

extension FoursquareEnum: Endpoint {
    
    static let apiKeyParam = [URLQueryItem(name: "client_id", value: clientID), URLQueryItem(name: "client_secret", value: clientSecret)]
    
    var base: String {
        return "api.foursquare.com"
    }
    
    var path: String {
        switch self {
        case .search:
            return "/v2/venues/search"
        case .venueDetail(let venueID):
            return "/v2/venues/\(venueID)" + "\(FoursquareEnum.apiKeyParam)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let latitude, let longitude, let query):
            return [URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"), URLQueryItem(name: "v", value: "20190507"), URLQueryItem(name: "intent", value: "browse"), URLQueryItem(name: "radius", value: "100000"), URLQueryItem(name: "query", value: query)] + FoursquareEnum.apiKeyParam
        default:
            return []
            
        }
        
        
    }
    
    
}
