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

    var venue: Venues!
    private var client = FoursquareClient()
    
    var id: String!
    var localCoordinate: CLLocationCoordinate2D!
    var fullAdress: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        client.getVenues(with: .venueDetail(venueID: id)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response = response?.response.venues[0] else { return }
                DispatchQueue.main.async {
                    self?.venue = response
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
        
        let mapAnnotation = VenueMap(title: venue.name, coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng))
       mapView.addAnnotation(mapAnnotation)
        
        nameLabel.text = venue.name
        categoryNameLabel.text = venue.categories?[0].name
        for address in venue.location.formattedAddress! {
           fullAdress += address + "\n"
        }
        addressLabel.text = fullAdress
        
        
        
       
        let viewRegion = MKCoordinateRegion(center: localCoordinate, latitudinalMeters: 40000, longitudinalMeters: 40000)
        mapView.setRegion(viewRegion, animated: false)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.removeFromSuperview()
        
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
