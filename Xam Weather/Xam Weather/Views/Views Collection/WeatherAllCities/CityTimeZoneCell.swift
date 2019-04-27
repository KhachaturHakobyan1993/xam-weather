//
//  CityTimeZoneCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class CityTimeZoneCell: UITableViewCell {
	@IBOutlet private weak var cityInfoLabel: UILabel!
	@IBOutlet private weak var timeLabel: UILabel!
	
	var city: WeatherCityViewModel! {
		didSet {
			self.cityInfoLabel.text = self.city.info
			self.timeLabel.text = self.city.time
		}
	}
}
