//
//  VenueMap.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 14.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import MapKit

class VenueMap: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

