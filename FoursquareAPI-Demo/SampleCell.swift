//
//  SampleCell.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 29.10.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit

class SampleCell: UITableViewCell {

    @IBOutlet weak var sampleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("Clicked")
    }
    
}
