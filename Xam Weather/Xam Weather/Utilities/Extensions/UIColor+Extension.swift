//
//  UIColor+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

extension UIColor {
	enum App: String {
		case lightBlue
		case transparentWhite
		case dirtyWhite
		
		var value: UIColor {
			return UIColor(named: self.rawValue)!
		}
	}
}

