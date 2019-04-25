//
//  NibLoadable.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

protocol NibLoadable {
	func xibSetup()
}

extension NibLoadable {
	func xibSetup() {
		guard let superView = self as? UIView,
			let view = self.loadViewFromNib(for: type(of: superView)) else { return }
		view.frame = superView.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		superView.addSubview(view)
	}
	
	private func loadViewFromNib(for aClass: Swift.AnyClass) -> UIView? {
		let bundle = Bundle(for: aClass)
		let nibName = String(describing: aClass)
		let nib = UINib(nibName: nibName, bundle: bundle)
		guard let view = nib.instantiate(withOwner: self).first as? UIView else { return nil }
		return view
	}
}
