//
//  ExtendedInfo.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation

enum ExtendedInfo: String, CaseIterable {
	case sunrise, sunset, chanceOfRain, humidity, wind, feelLike, precipitation, pressure, visibility, uvIndex
	
	var stringValue: String {
		var textString = ""
		switch self {
		case .uvIndex:
			textString = "UV INDEX"
		case .chanceOfRain:
			textString = "CHANCE OF RAIN"
		case .feelLike:
			textString = "FEEL LIKE"
		default:
			textString = self.rawValue.uppercased()
		}
		return "\(textString):  "
	}
}


