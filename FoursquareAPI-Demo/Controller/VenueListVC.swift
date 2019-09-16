//
//  VenueListVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListVC: UIViewController, CLLocationManagerDelegate, DelegateProtocol, UITextFieldDelegate {
    
    private let client = FoursquareClient()
    var locationManager: CLLocationManager?
  
    var flag = true
    
    var venue = [Venues]()
    var keyword: String = ""
    var localCoordinate: CLLocationCoordinate2D!
    
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var venueListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        keywordTextField.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
       
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        }
        
        keywordTextField.delegate = self
        keywordTextField.addBottomBorder()
        
        keywordDoneButton()
       
    }
    
    func sendDataToFirstViewController(myData: CLLocationCoordinate2D) {
        venue.removeAll()
        guard let keyword = keywordTextField.text, !keyword.isEmpty else { return }
        localCoordinate = myData
        getVenue(query: keyword, latitude: "\(myData.latitude)", longitude: "\(myData.longitude)")
    }
    
     func keywordDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneTapped))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        keywordTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneTapped(){
        keywordTextField.resignFirstResponder()
    }
    
    @IBAction func performSegueBarButton(_ sender: UIButton) {
        
        if let keyword = keywordTextField.text, !keyword.isEmpty {
            performSegue(withIdentifier: "locationRetrieve", sender: self)
        }else {
            presentAlert(withTitle: "Please", message: "Enter a Keyword")
        }
    }
    
    @IBAction func performSegueVenuesOnMap(_ sender: UIButton) {
        if let keyword = keywordTextField.text, !keyword.isEmpty {
            performSegue(withIdentifier: "venuesOnMap", sender: self)
        }else {
            presentAlert(withTitle: "Please", message: "Enter a Keyword")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        if flag {
            localCoordinate = locValue
            locationManager!.stopUpdatingLocation()
            flag = false
        }
    }

    func getVenue(query: String, latitude: String, longitude: String ) {
//        41.111226
//        29.024223
        client.getVenues(with: .search, query: query, latitude: latitude, longitude: longitude) { [weak self] result in

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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyword = keywordTextField.text ?? ""
        
        if keyword == "" {
            
        }
        else {
            venue.removeAll()
            getVenue(query: keyword, latitude: "\(localCoordinate.latitude)", longitude: "\(localCoordinate.longitude)")
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}


extension VenueListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if venue.count == 0 {
            venueListTableView.setEmptyView(title: "Enter a Keyword", message: "Your venues will be here.")
        }
        else {
            venueListTableView.restore()
        }
        return venue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VenueListCell
        let venues = venue[indexPath.row]
        
        cell.configureCell(venues: venues)

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
                vc.categoryName = venueDetail.categories?[0].name
                vc.formattedAddress = venueDetail.location.formattedAddress
                vc.coordinate = CLLocationCoordinate2D(latitude: venueDetail.location.lat, longitude: venueDetail.location.lng)
               vc.localCoordinate = localCoordinate
            }
        }
        
        if segue.identifier == "locationRetrieve" {
            if let keyword = keywordTextField.text, !keyword.isEmpty {
                if let vc = segue.destination as? LocationSelectionVC {
                    vc.delegate = self
                }
            }
           
        }
        
        if segue.identifier == "venuesOnMap" {
            if let vc = segue.destination as? VenuesOnMapVC {
                var coordinates = [CLLocationCoordinate2D]()
                for venueCoordinates in venue {
                   coordinates.append(CLLocationCoordinate2D(latitude: venueCoordinates.location.lat, longitude: venueCoordinates.location.lng))
                }
                vc.coordinates = coordinates
            }
        }
        
        
    }
    
    
}




