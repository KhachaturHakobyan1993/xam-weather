//
//  WeatherCityDocument.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class WeatherCityDocument {
	let allCities: [WeatherCity]
	
	init() {
		guard let asset = NSDataAsset(name: "Cities") else {
			fatalError("Missing data asset: Currencies")
		}
		let jsonDecoder = JSONDecoder()
		guard let allCities = try? jsonDecoder.decode([WeatherCity].self, from: asset.data) else {
				fatalError("Missing data: Currencies")
		}
		self.allCities = allCities
	}
}
