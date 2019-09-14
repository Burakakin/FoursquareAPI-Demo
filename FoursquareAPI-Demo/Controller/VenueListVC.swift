//
//  VenueListVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListVC: UIViewController, CLLocationManagerDelegate, DelegateProtocol {
    
    func sendDataToFirstViewController(myData: CLLocationCoordinate2D) {
        venue.removeAll()
        getVenue(latitude: "\(myData.latitude)", longitude: "\(myData.longitude)")
    }
    

    private let client = FoursquareClient()
    var locationManager: CLLocationManager?
  
    var flag = true
    
    var venue = [Venues]()
    
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var venueListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        keywordTextField.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
       
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        }
        
        
//        getVenue()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        
        
        if flag {
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
            
            getVenue(latitude: "\(locValue.latitude)", longitude: "\(locValue.longitude)")
           
            locationManager!.stopUpdatingLocation()
            flag = false
           
        }
        
    }

    func getVenue(latitude: String, longitude: String ) {
//        41.111226
//        29.024223
        client.getVenues(with: .search, query: "Supplementler", latitude: latitude, longitude: longitude) { [weak self] result in

            switch result {
            case .success(let response):
                guard let response = response?.response.venues else { return }
                self?.venue.append(contentsOf: response)
                DispatchQueue.main.async {
                    self!.venueListTableView.reloadData()
                }
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
        performSegue(withIdentifier: "showDetail", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            let indexPath = self.venueListTableView.indexPathForSelectedRow!
            let venueDetail = venue[indexPath.row]
            if let vc = segue.destination as? VenueDetailVC {
                vc.name = venueDetail.name
                vc.categoryName = venueDetail.categories[0].name
                vc.formattedAddress = venueDetail.location.formattedAddress
                vc.coordinate = CLLocationCoordinate2D(latitude: venueDetail.location.lat, longitude: venueDetail.location.lng)
               
            }
        }
        
        if segue.identifier == "locationRetrieve" {
            if let vc = segue.destination as? LocationSelectionVC {
                vc.delegate = self
            }
            
            
        }
        
        
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
