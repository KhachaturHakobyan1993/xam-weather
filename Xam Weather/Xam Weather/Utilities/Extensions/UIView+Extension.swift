//
//  UIView+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

extension UIView {
	
	public func fillSuperview() {
		self.translatesAutoresizingMaskIntoConstraints = false
		if let superview = self.superview {
			self.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
			self.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
			self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
		}
	}
	
	public func anchorCenterXToSuperview(constant: CGFloat = 0) {
		self.translatesAutoresizingMaskIntoConstraints = false
		if let anchor = self.superview?.centerXAnchor {
			self.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}
	
	public func anchorCenterYToSuperview(constant: CGFloat = 0) {
		self.translatesAutoresizingMaskIntoConstraints = false
		if let anchor = self.superview?.centerYAnchor {
			self.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}
	
	public func equalWidthToHeight() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
	}
	
	public func equalHeightToWidth() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
	}
	
	public func anchorCenterSuperview() {
		anchorCenterXToSuperview()
		anchorCenterYToSuperview()
	}
	
	func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
		
		anchorWithConstantsToTop(top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
	}
	
	func anchorWithConstantsToTop(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
		
		_ = anchor(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
	}
	
	func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
		translatesAutoresizingMaskIntoConstraints = false
		
		var anchors = [NSLayoutConstraint]()
		
		if let top = top {
			anchors.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
		}
		
		if let left = left {
			anchors.append(self.leftAnchor.constraint(equalTo: left, constant: leftConstant))
		}
		
		if let bottom = bottom {
			anchors.append(self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
		}
		
		if let right = right {
			anchors.append(self.rightAnchor.constraint(equalTo: right, constant: -rightConstant))
		}
		
		if widthConstant > 0 {
			anchors.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
		}
		
		if heightConstant > 0 {
			anchors.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
		}
		
		anchors.forEach({$0.isActive = true})
		
		return anchors
	}
}
