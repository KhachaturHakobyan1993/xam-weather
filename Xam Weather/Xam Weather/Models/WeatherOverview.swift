//
//  WeatherOverview.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

struct WeatherOverview: Codable {
	let cod: String
	let message: Double
	let cnt: Int
	let list: [List]
	let city: WeatherCity
}

extension WeatherOverview {
	static func fetchWeatherOverview(_ city: String,
									 _ completion: @escaping (_ weatherOverview: WeatherOverview?) -> Void) {
		guard let isWeatherCity = WeatherCity.allCities.first(where: {$0.name.lowercased().contains(city.lowercased())}),
			let infoPlist = Bundle.main.infoDictionary,
			let urlString = infoPlist["BaseURL"] as? String,
			let baseURL = URL(string: urlString),
			let apiKey = infoPlist["ApiKey"] as? String else { completion(nil); return }
		
		let id = isWeatherCity.id.description
		let query: [String: String] = [
			"appid": apiKey,
			"id": id
		]
		guard let forecastURL = baseURL.withQueries(query) else { completion(nil); return }
		
		URLSession.shared.dataTask(with: forecastURL, completionHandler: { (data, _, error) in
			guard let data = data, error == nil else { completion(nil); return }
			let jsonDecoder = JSONDecoder()
			guard let weatherOverview = try? jsonDecoder.decode(WeatherOverview.self, from: data) else { completion(nil); return }
			DispatchQueue.main.async {
				completion(weatherOverview)
			}
		}).resume()
	}
}


struct List: Codable {
	let dt: Int
	let main: MainClass
	let weather: [Weather]
	let clouds: Clouds
	let wind: Wind
	let snow: Snow
	let sys: Sys
	let dtTxt: String
	
	enum CodingKeys: String, CodingKey {
		case dt, main, weather, clouds, wind, snow, sys
		case dtTxt = "dt_txt"
	}
}

struct Clouds: Codable {
	let all: Int
}

struct MainClass: Codable {
	let temp, tempMin, tempMax, pressure: Double
	let seaLevel, grndLevel: Double
	let humidity: Int
	let tempKf: Double
	
	enum CodingKeys: String, CodingKey {
		case temp
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure
		case seaLevel = "sea_level"
		case grndLevel = "grnd_level"
		case humidity
		case tempKf = "temp_kf"
	}
}

struct Snow: Codable {
	let the3H: Double?
	
	enum CodingKeys: String, CodingKey {
		case the3H = "3h"
	}
}

struct Sys: Codable {
	let pod: Pod
}

enum Pod: String, Codable {
	case d = "d"
	case n = "n"
}

struct Weather: Codable {
	let id: Int
	let main: MainEnum
	let description: Description
	let icon: String
}

enum Description: String, Codable {
	case brokenClouds = "broken clouds"
	case clearSky = "clear sky"
	case fewClouds = "few clouds"
	case lightSnow = "light snow"
	case scatteredClouds = "scattered clouds"
}

enum MainEnum: String, Codable {
	case clear = "Clear"
	case clouds = "Clouds"
	case snow = "Snow"
}

struct Wind: Codable {
	let speed, deg: Double
}
