//
//  WeatherFormatable.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

protocol WeatherFormatable {

}

extension WeatherFormatable {
	func getCelsius(kelvin: Double) -> String {
		let celsius: Int = Int((kelvin - 273.15))
		return celsius.description
	}
	
	func getHour(dateString: String) -> String {
		let formetter = DateFormatter()
		formetter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = formetter.date(from: dateString) ?? Date()
		formetter.dateFormat = "HH"
		let hour = formetter.string(from: date)
		return hour
	}
	
	func getTemperature(temp: Double) -> String {
		let temp = self.getCelsius(kelvin: temp)
		return "\(temp.description)°"
	}
	
	func getWeatherIcon(description: Description, pod: Pod) -> UIImage {
		switch pod {
		case .d:
			switch description {
			case .brokenClouds: return #imageLiteral(resourceName: "imageRainy")
			case .clearSky: return #imageLiteral(resourceName: "imageSunny")
			case .fewClouds: return #imageLiteral(resourceName: "imageDayPartlyCloudy")
			case .lightSnow: return #imageLiteral(resourceName: "imageNightCloudy")
			case .scatteredClouds: return #imageLiteral(resourceName: "imageDayPartlyCloudy")
			}
		case .n:
			switch description {
			case .brokenClouds: return #imageLiteral(resourceName: "imageNightPartlyCloudy")
			case .clearSky: return #imageLiteral(resourceName: "imageNightClear")
			case .fewClouds: return #imageLiteral(resourceName: "imageNightCloudy")
			case .lightSnow: return #imageLiteral(resourceName: "imageRainy")
			case .scatteredClouds: return #imageLiteral(resourceName: "imageNightCloudy")
			}
		}
	}
}
