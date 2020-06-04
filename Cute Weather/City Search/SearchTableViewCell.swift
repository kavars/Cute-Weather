//
//  SearchTableViewCell.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 28.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var country: UILabel!
    
    var cityID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
