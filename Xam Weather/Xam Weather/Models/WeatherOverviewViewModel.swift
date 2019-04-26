//
//  WeatherOverviewViewModel.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import UIKit

struct WeatherOverviewViewModel: WeatherFormatable {
	
	private var weatherOverView: WeatherOverview!
	
	init(weatherOverView: WeatherOverview) {
		self.weatherOverView = weatherOverView
	}
	
	var cityAndDescriptionAttributedString: NSMutableAttributedString? {
		let cityName = self.weatherOverView.city.name
		let weatherDescription = self.weatherOverView.list.first?.weather.first?.description.rawValue.capitalized ?? "--"
		
		let attributedString = NSMutableAttributedString.setupWithText(cityName, description: "\n" + weatherDescription, textFont: UIFont.systemFont(ofSize: 34), descriptionFont: UIFont.systemFont(ofSize: 16), textColor: UIColor.white, descriptionColor: UIColor.white)
		attributedString?.centerAlignWithSpacing(1.0)
		return attributedString
	}
	
	var lowTemperature: String {
		guard let temperature = self.weatherOverView.list.first?.main.tempMin else { return "-"}
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)"
	}
	
	var highTemperature: String {
		guard let temperature = self.weatherOverView.list.first?.main.tempMax else { return "-"}
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)"
	}
	
	var weekDay: String {
		return "\("Monday")  Today"
	}
	
	var temperature: String {
		guard let temperature = self.weatherOverView.list.first?.main.temp else { return "-"}
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)°"
	}
	
	var lists: [List] {
		guard self.weatherOverView.list.count >= 12 else { return self.weatherOverView.list }
		let lists = Array(self.weatherOverView.list[0..<12])
		return lists
	}
}
