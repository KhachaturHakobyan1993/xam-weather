//
//  VerticalWeatherCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class VerticalWeatherCell: UICollectionViewCell {
	
	let hourLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 18))
		label.textAlignment = .center
		return label
	}()
	
	let temperatureLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 18))
		label.textAlignment = .center
		return label
	}()
	
	let weatherIcon: AutoFittingImageView = {
		let iv = AutoFittingImageView()
		return iv
	}()
	
	 var datasourceItem: Any? {
		didSet {
//			guard let weatherHourly = datasourceItem as? WeatherHourly else {
//				return
//			}
//			hourLabel.text = weatherHourly.hour
//			temperatureLabel.text = addDegreeSign(toNumber: weatherHourly.temperature ?? 0)
//			if let imageIconName = weatherHourly.description?.stringValue {
//				weatherIcon.image = UIImage(named: imageIconName)
//			}
		}
	}
	
	 func setupViews() {
		self.addSubview(self.hourLabel)
		self.addSubview(self.temperatureLabel)
		self.addSubview(self.weatherIcon)
		
		self.weatherIcon.anchorCenterSuperview()
		self.weatherIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
		self.weatherIcon.equalHeightToWidth()
		
		_ = self.temperatureLabel.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
		
		_ = self.hourLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 2, bottomConstant: 0, rightConstant: 2, widthConstant: 0, heightConstant: 0)
	}
}
