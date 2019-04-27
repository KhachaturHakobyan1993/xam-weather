//
//  ListViewModel.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

struct ListViewModel: WeatherFormatable {
	
	private var list: List
	
	init(list: List) {
		self.list = list
	}
	
	var hour: String {
		let hour = self.getHour(dateString: self.list.dtTxt)
		return hour
	}
	
	var weekDay: String {
		let weekDay = self.getWeekDay(dateString: self.list.dtTxt)
		return weekDay
	}
	
	var temperature: String {
		let temperature = self.getTemperature(temp: self.list.main.temp)
		return temperature
	}
	
	var lowTemperature: String {
		let temperature = self.list.main.tempMin
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)"
	}
	
	var highTemperature: String {
		let temperature = self.list.main.tempMax
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)"
	}
	
	var weatherIcon: UIImage? {
		guard let weather = self.list.weather.first else { return nil}
		let weatherIcon = self.getWeatherIcon(description: weather.description, pod: self.list.sys.pod)
		return weatherIcon
	}
}
