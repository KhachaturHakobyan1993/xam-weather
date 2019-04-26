//
//  WeatherOverviewViewModel.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import UIKit

struct WeatherOverviewViewModel {
	
	private var weatherOverView: WeatherOverview!
	
	init(weatherOverView: WeatherOverview) {
		self.weatherOverView = weatherOverView
	}
	
	var cityAndDescriptionAttributedString: NSMutableAttributedString? {
		let cityName = weatherOverView.name
		let weatherDescription = weatherOverView.weather.first?.main.capitalized ?? "--"
		
		let attributedString = NSMutableAttributedString.setupWithText(cityName, description: "\n" + weatherDescription, textFont: UIFont.systemFont(ofSize: 34), descriptionFont: UIFont.systemFont(ofSize: 16), textColor: UIColor.white, descriptionColor: UIColor.white)
		attributedString?.centerAlignWithSpacing(1.0)
		return attributedString
	}
	
	var lowTemperature: String {
		let temperature = weatherOverView.main.tempMin
		return "\(temperature)"
	}
	
	var highTemperature: String {
		let temperature = weatherOverView.main.tempMax
		return "\(temperature)"
	}
	
	var weekDay: String {
		//let weekDayText = weatherOverView?.weekDay ?? "--"
		return "\("Monday")  Today"
	}
	
	var temperature: String {
		let temperature = weatherOverView.main.temp
		return "\(temperature)°"
	}
}
