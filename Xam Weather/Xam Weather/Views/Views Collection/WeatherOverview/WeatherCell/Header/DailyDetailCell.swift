//
//  DailyDetailCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class DailyDetailCell: UICollectionViewCell {
	
	let dayLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	let temperatureHighLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	let temperatureLowLabel: SemiTransparentLabel = {
		let label = SemiTransparentLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	let weatherIcon: AutoFittingImageView = {
		let imageView = AutoFittingImageView()
		return imageView
	}()
	
	 var datasourceItem: Any? {
		didSet {
//			guard let weatherDaily = datasourceItem as? WeatherDaily else {
//				return
//			}
//			let weatherDailyViewModel = WeatherDailyViewModel(weatherDaily: weatherDaily)
//			dayLabel.text = weatherDailyViewModel.weekDay
//			weatherIcon.image = weatherDailyViewModel.weatherImage
//			temperatureLowLabel.text = weatherDailyViewModel.low
//			temperatureHighLabel.text = weatherDailyViewModel.high
		}
	}
	
	 func setupViews() {
		self.addSubview(self.weatherIcon)
		self.addSubview(self.dayLabel)
		
		self.weatherIcon.anchorCenterSuperview()
		self.weatherIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
		self.weatherIcon.equalWidthToHeight()
		
		self.dayLabel.anchorWithConstantsToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: weatherIcon.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 4)
		
		let stackView = UIStackView.setupStackview(leftView: temperatureHighLabel, rightView: temperatureLowLabel, portionleft: 0.5, portionright: 0.5, spacing: 0)
		self.temperatureHighLabel.textAlignment = .left
		self.temperatureLowLabel.textAlignment = .right
		addSubview(stackView)
		stackView.anchorWithConstantsToTop(topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
		stackView.widthAnchor.constraint(equalToConstant: 66).isActive = true
	}
}

