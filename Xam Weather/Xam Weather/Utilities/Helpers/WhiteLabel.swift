//
//  WhiteLabel.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class WhiteLabel: UILabel {
	
	public init(font: UIFont? = nil) {
		super.init(frame: .zero)
		self.font = font
		self.setupColor()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupColor()
	}
	
	private func setupColor() {
		self.textColor = UIColor.App.dirtyWhite.value
	}
}
