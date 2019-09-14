//
//  VenueListVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListVC: UIViewController, CLLocationManagerDelegate {

    private let client = FoursquareClient()
    var locationManager: CLLocationManager?
   
    
    var venue = [Venues]()
    
    @IBOutlet weak var venueListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        
        getVenue()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.longitude) \(locValue.latitude)")
        
    }

    func getVenue() {
//        41.111226
//        29.024223
        
        client.getVenues(with: .search, query: "Supplementler", latitude: "36.873809251151684", longitude: "30.65218424460133") { [weak self] result in
            
            switch result {
            case .success(let response):
                guard let response = response?.response.venues else { return }
                self?.venue.append(contentsOf: response)
                DispatchQueue.main.async {
                    self!.venueListTableView.reloadData()
                }
//                print(self!.venue[0].id)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

}


extension VenueListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VenueListCell
        let venues = venue[indexPath.row]
        let categories = venues.categories[0]
        
        cell.name.text = venues.name
        cell.categoryName.text = categories.name
        cell.distance.text = "\(venues.location.distance)m"
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venues = venue[indexPath.row]
        let id = venues.id
        print(id)
    }
    
    
    
    
}
