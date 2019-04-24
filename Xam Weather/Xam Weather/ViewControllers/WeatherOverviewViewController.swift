//
//  WeatherOverviewViewController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherOverviewViewController: UIViewController {
	private let locationManager = CLLocationManager()
	private var currentCity: String! {didSet{ self.fetchWeatherOverview(self.currentCity)}}
	private var weatherOverview: WeatherOverview!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.requestCurrentLocation()
	}
	
	
	// MARK: - Methods Setup -

	private func requestCurrentLocation() {
		self.locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			self.locationManager.delegate = self
			self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
			self.locationManager.startUpdatingLocation()
		}
	}
	
	// MARK: - Requests -
	
	private func fetchWeatherOverview(_ city: String) {
		WeatherOverview.fetchWeatherOverview(city) { (weatherOverview) in
			self.weatherOverview = weatherOverview
		}
	}
}


// MARK: - CLLocationManagerDelegate

extension WeatherOverviewViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		location.getCity { (city) in
			guard let city = city,
			self.currentCity != city else { return }
			self.currentCity = city
		}
	}
}
