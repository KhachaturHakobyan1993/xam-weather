//
//  WeatherTopHeaderCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class WeatherTopHeaderCell: UICollectionViewCell {
	
	private let cityNameTextView: PassiveTextView = {
		let textView = PassiveTextView()
		textView.font = UIFont.systemFont(ofSize: 18)
		return textView
	}()
	
	private let temperatureLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 88, weight: UIFont.Weight.thin))
		label.textAlignment = .center
		return label
	}()
	
	private let todayLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private let temperatureHighLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private let temperatureLowLabel: SemiTransparentLabel = {
		let label = SemiTransparentLabel(font: UIFont.systemFont(ofSize: 19))
		return label
	}()
	
	private var topConstraint: NSLayoutConstraint?
	private var maxHeaderHeight: CGFloat?
	
	var datasourceItem: WeatherOverviewViewModel! {
		didSet {
			guard let weatherOverview = self.datasourceItem else { return }
			self.setupViews()
			self.cityNameTextView.attributedText = weatherOverview.cityAndDescriptionAttributedString
			self.temperatureLabel.text = weatherOverview.temperature
			self.todayLabel.text = weatherOverview.weekDay
			self.temperatureLowLabel.text = weatherOverview.lowTemperature
			self.temperatureHighLabel.text = weatherOverview.highTemperature
		}
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.animateAlpha()
	}
	
	
	// MARK: - Methods Setup -
	
	func setupViews() {
		self.addSubview(self.cityNameTextView)
		self.addSubview(self.temperatureLabel)
		self.addSubview(self.todayLabel)
		
		self.cityNameTextView.anchorCenterXToSuperview()
		self.topConstraint = self.cityNameTextView.topAnchor.constraint(equalTo: self.topAnchor, constant:  self.frame.height * 0.18)
		self.topConstraint?.isActive = true
		self.cityNameTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.8).isActive = true
		self.cityNameTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		self.temperatureLabel.anchorCenterXToSuperview()
		self.temperatureLabel.topAnchor.constraint(equalTo: self.cityNameTextView.bottomAnchor, constant: -2).isActive = true
		self.temperatureLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.5).isActive = true
		
		let stackView = UIStackView.setupStackview(leftView: self.temperatureHighLabel, rightView: temperatureLowLabel, portionleft: 0.5, portionright: 0.5, spacing: 0)
		self.temperatureHighLabel.textAlignment = .left
		self.temperatureLowLabel.textAlignment = .right
		addSubview(stackView)
		
		_  = stackView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: GlobalConstant.margin, widthConstant: 66, heightConstant: 30)
		_ = self.todayLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: GlobalConstant.margin, bottomConstant: 0, rightConstant: 0, widthConstant: (GlobalConstant.screenWidth - 2 * GlobalConstant.margin) * 0.6, heightConstant: 30)
	}
	
	
	// MARK: - Methods -
	
	private func animateAlpha() {
		self.topConstraint?.constant = self.frame.height * 0.18
		
		let alpha = self.calculateAlpha()
		self.temperatureLabel.alpha = alpha
		self.temperatureLowLabel.alpha = alpha
		self.temperatureHighLabel.alpha = alpha
		self.todayLabel.alpha = alpha
	}
	
	private func calculateAlpha() -> CGFloat {
		let transparentY = self.temperatureLabel.frame.height + self.temperatureLabel.frame.origin.y
		return max((self.frame.height - transparentY) / (WeatherHeaders.topHeader.defaultHeight - transparentY), 0)
	}
}
