//
//  SearchButton.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

final class SearchButton: UIButton {
    @IBOutlet var locationLabel: UILabel!

	
    override func awakeFromNib() {
        super.awakeFromNib()
		self.setup()
    }
    
	
	// MARK: - Methods Setup -

	private func setup() {
		self.clipsToBounds = true
		self.locationLabel.numberOfLines = 1
		self.locationLabel.sizeToFit()
		self.locationLabel.layoutIfNeeded()
		self.layer.borderColor = UIColor.white.cgColor
		self.layer.borderWidth = 2
		self.layer.cornerRadius = 10
	}
	
	
    // MARK: - Methods -
    
    func setUpAnimation() {
		self.locationLabel.layer.removeAllAnimations()
        self.locationLabel.sizeToFit()
		self.locationLabel.layoutIfNeeded()
        self.animate()
    }
    
    private func animate() {
		guard let frame = self.superview?.bounds else { return }
		let animation = CABasicAnimation(keyPath: "transform.translation.x")
		animation.duration = 3
		animation.repeatCount = .greatestFiniteMagnitude
		animation.autoreverses = true;
		animation.fromValue = 0
		animation.toValue = frame.width - 2 * (self.locationLabel.frame.width) - 40
		self.locationLabel.layer.add(animation, forKey: "transform.translation.x")
    }
}
