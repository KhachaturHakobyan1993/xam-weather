//
//  WeatherOverview.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

struct WeatherOverview: Codable {
	let coord: Coord
	let weather: [Weather]
	let base: String
	let main: Main
	let visibility: Int
	let wind: Wind
	let clouds: Clouds
	let dt: Int
	let sys: Sys
	let id: Int
	let name: String
	let cod: Int
	
}

extension WeatherOverview {
	static func fetchWeatherOverview(_ city: String,
									 _ completion: @escaping (_ weatherOverview: WeatherOverview?) -> Void) {
		let urlString = "https://samples.openweathermap.org/data/2.5/weather?q=\(city)&appid=b6907d289e10d714a6e88b30761fae22"
		guard let url = URL(string: urlString) else { completion(nil); return }
		URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
			guard let data = data, error == nil else { completion(nil); return }
			let jsonDecoder = JSONDecoder()
			guard let weatherOverview = try? jsonDecoder.decode(WeatherOverview.self, from: data) else { completion(nil); return }
			DispatchQueue.main.async {
				completion(weatherOverview)
			}
		}).resume()
	}
}

struct Clouds: Codable {
	let all: Int
}

struct Coord: Codable {
	let lon, lat: Double
}

struct Main: Codable {
	let temp: Double
	let pressure, humidity: Int
	let tempMin, tempMax: Double
	
	enum CodingKeys: String, CodingKey {
		case temp, pressure, humidity
		case tempMin = "temp_min"
		case tempMax = "temp_max"
	}
}

struct Sys: Codable {
	let type, id: Int
	let message: Double
	let country: String
	let sunrise, sunset: Int
}

struct Weather: Codable {
	let id: Int
	let main, description, icon: String
}

struct Wind: Codable {
	let speed: Double
	let deg: Int
}
