//
//  ExtendedDetailCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class ExtendedDetailCell: UICollectionViewCell {
	
	private let extendedInfoTextView: PassiveTextView = {
		let tv = PassiveTextView()
		return tv
	}()
	
	private let separatorLineView: UIView = {
		let lineView = UIView()
		lineView.backgroundColor = UIColor(white: 0, alpha: 0.5)
		lineView.isHidden = true
		return lineView
	}()
	
	 var datasourceItem: Any? {
		didSet {
//			guard let detail = datasourceItem as? [ExtendedInfo : String] else { return }
//
//			for (key, value) in detail {
//				let attributedText = NSMutableAttributedString.setupWithText(key.stringValue, description: "\n\(value)",
//					textFont: UIFont.systemFont(ofSize: 14),
//					descriptionFont: UIFont.systemFont(ofSize: 28),
//					textColor: UIColor.weatherSemiTransparent(),
//					descriptionColor: .white)
//				attributedText?.setLineSpacing(1.0)
//				extendedInfoTextView.attributedText = attributedText
//			}
		}
	}
	
	 func setupViews() {
		self.addSubview(self.extendedInfoTextView)
		self.addSubview(self.separatorLineView)
		self.extendedInfoTextView.fillSuperview()
		self.separatorLineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
		self.separatorLineView.isHidden = false
	}
}

