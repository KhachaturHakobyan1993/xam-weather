//
//  City.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import CoreLocation

struct City {
	let name: String
	let location: CLLocation
}


// MARK: - Equatable -

extension City: Equatable {
	static func == (lhs: City, rhs: City) -> Bool {
		return lhs.name == rhs.name
	}
}
