//
//  Venue.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import Foundation

struct FoursquareAPIResponse: Decodable {
    let response: Response
}

struct Response: Decodable {
    let venues: [Venues]
}

struct Venues: Decodable {
    let id: String
    let name: String
    let location: Location
    let categories: [Categories]
}

struct Location: Decodable {
    let address: String?
    let lat: Double
    let lng: Double
    let distance: Int
    let formattedAddress: [String]?
}

struct Categories: Decodable {
    let id: String
    let name: String
}
