//
//  CityCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit


class CityCell: UICollectionViewCell {
	@IBOutlet private weak var infoLabel: UILabel!
	
	var city: WeatherCityViewModel! {
		didSet {
			self.infoLabel.text = self.city.info
		}
	}
}
