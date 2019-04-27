//
//  AutoFittingImageView.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class AutoFittingImageView: UIImageView {
	
	public init() {
		super.init(frame: .zero)
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	private func setup() {
		self.contentMode = .scaleAspectFit
		self.clipsToBounds = true
	}
}
