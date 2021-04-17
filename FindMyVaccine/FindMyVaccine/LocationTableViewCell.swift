//
//  LocationTableViewCell.swift
//  FindMyVaccine
//
//  Created by Hung Nguyen on 4/17/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var providerName: UILabel!
    
    @IBOutlet weak var appoinment: UILabel!
    @IBOutlet weak var location: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
