//
//  VenueDetail.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 19.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import Foundation

struct Venue: Decodable {
    let id: String
    let name: String
    let location: Location
    let categories: Categories
}


