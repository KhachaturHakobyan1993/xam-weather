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
	
	private var weatherOverView: WeatherOverview
	
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
		let todayDateString = self.weatherOverView.list.first?.dtTxt ?? ""
		let weekDay = self.getWeekDay(dateString: todayDateString)
		return "\(weekDay)  Today"
	}
	
	var temperature: String {
		guard let temperature = self.weatherOverView.list.first?.main.temp else { return "-"}
		let celsius = self.getCelsius(kelvin: temperature)
		return "\(celsius)°"
	}
	
	var listViewModelsOnly12: [ListViewModel] {
		guard self.weatherOverView.list.count >= 12 else { return self.weatherOverView.list.map({ListViewModel(list: $0)})}
		let lists = Array(self.weatherOverView.list[0..<12])
		let listViewModels = lists.map({ ListViewModel(list: $0) })
		return listViewModels
	}
	
	var listViewModels: [ListViewModel] {
		let listViewModels = self.weatherOverView.list.map({ ListViewModel(list: $0) })
		return listViewModels
	}
	
	var listViewModelsForWeekDays: [ListViewModel] {
		var lists = [ListViewModel]()
		for oneList in self.listViewModels {
			if !lists.contains(where: { $0.weekDay == oneList.weekDay}) {
				lists.append(oneList)
			}
		}
		return lists
	}
	
	var todayDescription: String {
		let description = self.getTodayCurrentDescriptionResult(weatherOverView: self.weatherOverView)
		let todayDescrption = "Today: \(description.rawValue.capitalized). The high will be \(self.highTemperature)°. \nTonight with a low of \(self.lowTemperature)°"
		return todayDescrption
	}
	
	var extendedInfo: [(ExtendedInfo, String)] {
		let extendedInfo = self.getInfo()
		return extendedInfo
	}
	
	private func getInfo() -> [(ExtendedInfo, String)] {
		var info = [(ExtendedInfo, String)]()
		for extendedInfoKey in ExtendedInfo.allCases {
			let tuple = (extendedInfoKey, self.setupString(key: extendedInfoKey))
			info.append(tuple)
		}
		return info
	}
	
	private func setupString(key: ExtendedInfo) -> String {
		guard let list = self.weatherOverView.list.first else { return ""}

		switch key {
		case .sunrise:
			return "6:18"
		case .sunset:
			return "21:13"
		case .chanceOfRain:
			return "0%"
		case .humidity:
			return self.floatToPercentageString(float: Float(list.main.humidity))
		case .wind:
			return "s 3km/hr"
		case .feelLike:
			return addDegreeSign(toNumber: "\(self.temperature)")
		case .precipitation:
			return "0 cm"
		case .pressure:
			return addUnit(GlobalConstant.Units.pressure, toNumber: list.main.pressure)
		case .visibility:
			return "14.5 km"
		case .uvIndex:
			return "4"
		}
	}
}
