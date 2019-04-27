//
//  WeatherCityViewModel.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherCityViewModel: WeatherFormatable {
	
	private var weatherCity: WeatherCity
	
	private var timeZone: TimeZone!
	
	init(weatherCity: WeatherCity) {
		self.weatherCity = weatherCity
	}
	
	var info: String {
		let info = self.weatherCity.name + ", " + self.weatherCity.country
		return info
	}
	
	var time: String {
		let dateFormetter = DateFormatter()
		dateFormetter.timeZone = self.timeZone
		dateFormetter.timeStyle = .short
		let time = dateFormetter.string(from: Date())
		return time
	}
	
	var convertedCity: City?
	
	func convertToCity(_ completion: @escaping () -> Void) {
		let location = CLLocation(latitude: self.weatherCity.coord.lat, longitude: self.weatherCity.coord.lon)
		let city = City(name: self.weatherCity.name, location: location)
		self.convertedCity = city

		location.getTimeZone { (timeZone) in
			guard let timeZone = timeZone else { return }
			self.timeZone = timeZone
			completion()
		}
	}
}
