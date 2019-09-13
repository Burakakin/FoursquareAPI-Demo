//
//  VenueListVC.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 13.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit

class VenueListVC: UIViewController {

    private let client = FoursquareClient()
    
    var venue = [Venues]()
    
    @IBOutlet weak var venueListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getVenue()
    }
    

    func getVenue() {
        client.getVenues(with: .search, query: "Supplementler", longitude: "41.111226", latitude: "29.024223") { [weak self] result in
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let venues = venue[indexPath.row]
        
        cell.textLabel?.text = venues.location.address
        return cell
    }
    
    
    
    
    
    
    
    
}
