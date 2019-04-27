//
//  Date+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation

extension Date {
	func dayOfWeek() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: self).capitalized
	}
}
