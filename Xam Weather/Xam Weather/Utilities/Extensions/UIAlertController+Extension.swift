//
//  UIAlertController+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

extension UIAlertController {
	static func showAlert(_ message: String, completion: (() -> Void)?) {
		var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
		while let presentedViewController = topMostViewController?.presentedViewController {
			topMostViewController = presentedViewController
		}

		let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
			if completion != nil {
				completion!()
			}
		}
		alertVC.addAction(okAction)
		DispatchQueue.main.async {
			topMostViewController?.present(alertVC, animated: true, completion: nil)
		}
	}
}
