//
//  VenueDetailVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 14.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import MapKit

class VenueDetailVC: UIViewController {

    var name: String!
    var coordinate: CLLocationCoordinate2D!
    var categoryName: String!
    var formattedAddress: [String]?
    var fullAdress: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mapAnnotation = VenueMap(title: name, coordinate: coordinate)
       mapView.addAnnotation(mapAnnotation)
        
        nameLabel.text = name
        categoryNameLabel.text = categoryName
        for address in formattedAddress! {
           fullAdress += address + "\n"
        }
        addressLabel.text = fullAdress
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    

}
