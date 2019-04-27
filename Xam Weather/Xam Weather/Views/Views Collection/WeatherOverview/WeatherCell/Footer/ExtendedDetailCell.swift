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
	
	var datasourceItem: (key: ExtendedInfo, value: String)! {
		didSet {
			guard let _ = self.datasourceItem else { return }
			self.setupViews()
			let key = self.datasourceItem.key
			let value = self.datasourceItem.value
			
			let attributedText = NSMutableAttributedString.setupWithText(key.stringValue, description: "\n\(value)",
				textFont: UIFont.systemFont(ofSize: 14),
				descriptionFont: UIFont.systemFont(ofSize: 28),
				textColor: UIColor.App.transparentWhite.value,
				descriptionColor: .white)
			attributedText?.setLineSpacing(1.0)
			self.extendedInfoTextView.attributedText = attributedText
		}
	}
	
	
	// MARK: - Methods Setup -
	
	func setupViews() {
		self.addSubview(self.extendedInfoTextView)
		self.addSubview(self.separatorLineView)
		self.extendedInfoTextView.fillSuperview()
		_ = self.separatorLineView.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
		self.separatorLineView.backgroundColor = UIColor.App.transparentWhite.value
		self.separatorLineView.isHidden = false
		
	}
}

