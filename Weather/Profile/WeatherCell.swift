//
//  WeatherCell.swift
//  Weather
//
//  Created by Rahul Lokhande on 06/10/23.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    var item:List? {
        didSet{
            guard let item = item else {
                return
            }
            date.text = item.formattedDate
            self.weatherDesc.text = item.weather[0].description
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
