//
//  WeatherCity.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation

struct WeatherCity: Codable {
	let id: Int
	let name: String
	let country: String
	let coord: Coord
	
	static var allCities: [WeatherCity] = WeatherCityDocument().allCities
}

struct Coord: Codable {
	let lon, lat: Double
}
