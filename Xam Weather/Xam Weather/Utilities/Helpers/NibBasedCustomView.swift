//
//  NibBasedCustomView.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class NibBasedCustomView: UIView, NibLoadable {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.xibSetup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.xibSetup()
	}
}
