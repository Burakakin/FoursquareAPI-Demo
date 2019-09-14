//
//  LocationSelectionVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 14.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import MapKit

protocol DelegateProtocol {
    func sendDataToFirstViewController(myData: CLLocationCoordinate2D)
}

class LocationSelectionVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: DelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureZ = UILongPressGestureRecognizer(target: self, action: #selector(self.revealRegionDetailsWithLongPressOnMap(sender:)))
        mapView.addGestureRecognizer(gestureZ)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        self.delegate?.sendDataToFirstViewController(myData: locationCoordinate)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }


}
