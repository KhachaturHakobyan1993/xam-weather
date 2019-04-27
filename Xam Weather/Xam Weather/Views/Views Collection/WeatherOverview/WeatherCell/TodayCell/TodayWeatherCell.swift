//
//  TodayWeatherCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class TodayWeatherCell: UICollectionViewCell {
	
	private let todayLabel: WhiteLabel = {
		let label = WhiteLabel(font: UIFont.systemFont(ofSize: 16))
		label.numberOfLines = 0
		return label
	}()
	
	private let separatorLineView: UIView = {
		let lineView = UIView()
		lineView.backgroundColor = UIColor(white: 0, alpha: 0.5)
		lineView.isHidden = true
		return lineView
	}()
	
	var datasourceItem: String? {
		didSet{
			self.setupViews()
			self.todayLabel.text = self.datasourceItem
		}
	}
	
	
	// MARK: - Methods Setup -
	
	func setupViews() {
		self.addSubview(self.todayLabel)
		self.addSubview(self.separatorLineView)
		self.todayLabel.anchorWithConstantsToTop(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 4, leftConstant: GlobalConstant.margin, bottomConstant: 4, rightConstant: GlobalConstant.margin)
		_ = self.separatorLineView.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
		self.separatorLineView.backgroundColor = UIColor.App.transparentWhite.value
		self.separatorLineView.isHidden = false
	}
}
