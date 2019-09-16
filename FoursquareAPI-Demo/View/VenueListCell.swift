//
//  VenueListCell.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 14.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit

class VenueListCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(venues: Venues) {
        let categories = venues.categories?[0]
        
        name.text = venues.name
        categoryName.text = categories?.name
        distance.text = "\(venues.location.distance)m"
    }

}
