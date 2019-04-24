//
//  UIViewController+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

extension UIViewController {
	func showAlert(_ message: String, completion: (() -> Void)?) {
		let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
			if completion != nil {
				completion!()
			}
		}
		alertVC.addAction(okAction)
		self.present(alertVC, animated: true, completion: nil)
	}
}
