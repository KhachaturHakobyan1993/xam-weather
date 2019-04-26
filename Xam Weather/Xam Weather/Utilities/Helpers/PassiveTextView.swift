//
//  PassiveTextView.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class PassiveTextView: UITextView {
	
	public init() {
		super.init(frame: .zero, textContainer: nil)
		self.setupPassiveState()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupPassiveState()
	}
	
	private func setupPassiveState() {
		self.backgroundColor = .clear
		self.isEditable = false
		self.isScrollEnabled = false
		self.isSelectable = false
	}
}
