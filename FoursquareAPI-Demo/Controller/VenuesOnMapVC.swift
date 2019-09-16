//
//  VenuesOnMapVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 16.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import MapKit

class VenuesOnMapVC: UIViewController, MKMapViewDelegate {
    
    var coordinates: [CLLocationCoordinate2D]!
    
    var venues = [VenueMap]()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        appendVenues()
        fetchVenuesOnMap(venues)
    }
    
    func appendVenues() {
        
        for coordinate in coordinates {
            let venue = VenueMap(title: "", coordinate: coordinate)
            venues.append(venue)
        }
    }
    
    func fetchVenuesOnMap(_ venues: [VenueMap]) {
        for venue in venues {
            let annotations = MKPointAnnotation()
            annotations.title = venue.title
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                venue.coordinate.latitude, longitude: venue.coordinate.longitude)
            mapView.addAnnotation(annotations)
        }
    }
    
    
}
