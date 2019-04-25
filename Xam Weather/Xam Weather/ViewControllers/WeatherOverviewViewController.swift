//
//  WeatherOverviewViewController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import CoreLocation

fileprivate enum CitySelectionOption {
	case current(city: City)
	case map(city: City)
	case autocomplete(city: City)
	case none
	
	var cityName: String {
		switch self {
		case let .current(city): return city.name
		case let .map(city): return city.name
		case let .autocomplete(city): return city.name
		case .none: return String()
		}
	}
	
	var isCurrent: Bool {
		switch self {
		case .current(_): return true
		case .map(_): return false
		case .autocomplete(_): return false
		case .none: return false
		}
	}
}

class WeatherOverviewViewController: UIViewController {
	@IBOutlet private weak var currentLocationBarButton: UIBarButtonItem!
	@IBOutlet private weak var mapBarButton: UIBarButtonItem!
	@IBOutlet private weak var searchButtonContainer: SearchButtonContainer!
	private let locationManager = CLLocationManager()
	private var clAuthorizationStatus: CLAuthorizationStatus = .notDetermined
	private var currentCity: City?
	private var weatherOverview: WeatherOverview!
	private var citySelcetion: CitySelectionOption = .none {didSet{self.updateCitySelectionOption()}}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setup()
		self.requestCurrentLocation()
	}
	
	
	// MARK: - Methods Setup -

	private func setup() {
		self.searchButtonContainer.delegate = self
	}
	
	private func requestCurrentLocation() {
		self.locationManager.requestAlwaysAuthorization()
		guard CLLocationManager.locationServicesEnabled() else { return }
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.startUpdatingLocation()
	}
	
	
	// MARK: - Methods -
	
	private func showWeatherOverviewForCurrentCity() {
		guard !self.citySelcetion.isCurrent,
			self.clAuthorizationStatus != .denied else {
				return
		}
		guard let currentCity = self.currentCity else {
			self.showAlert("Current city not found 😞", completion: nil)
			return
		}
		self.citySelcetion = .current(city: currentCity)
	}
	
	private func showApplePlacesViewController() {
		guard let applePlacesViewController = ApplePlacesViewController.instantiateFromStoryboard() else { return }
		applePlacesViewController.delegate = self
		self.navigationController?.present(applePlacesViewController, animated: true, completion: nil)
	}
	
	private func showMapViewController() {
		guard let mapViewController = MapViewController.instantiateFromStoryboard(initialCity: self.currentCity) else { return }
		mapViewController.delegate = self
		self.navigationController?.pushViewController(mapViewController, animated: true)
	}
	
	
	private func updateCitySelectionOption() {
		switch self.citySelcetion {
		case let .current(city): self.fetchWeatherOverview(city.name)
		case let .map(city): self.fetchWeatherOverview(city.name)
		case let .autocomplete(city): self.fetchWeatherOverview(city.name)
		case .none: break
		}
	}
	
	private func updateCitySelectionOptionUI() {
		self.currentLocationBarButton.image = #imageLiteral(resourceName: "imageMyLocationOff")
		self.mapBarButton.image = #imageLiteral(resourceName: "imageMapOff")
		self.searchButtonContainer.setSearchImage(#imageLiteral(resourceName: "imageSearchOff"))
		self.searchButtonContainer.updateSearchTitle(self.citySelcetion.cityName)
		switch self.citySelcetion {
		case .current(_): self.currentLocationBarButton.image = #imageLiteral(resourceName: "imageMyLocationOn")
		case .map(_): self.mapBarButton.image = #imageLiteral(resourceName: "imageMapOn")
		case .autocomplete(_): self.searchButtonContainer.setSearchImage(#imageLiteral(resourceName: "imageSearchOn"))
		case .none: break
		}
	}
	
	
	// MARK: - Requests -
	
	private func fetchWeatherOverview(_ city: String) {
		guard (Network.reachability?.isConnectedToNetwork)! else {
			UIAlertController.showAlert("Network Error 😞", completion: nil)
			self.citySelcetion = .none
			return
		}
		WeatherOverview.fetchWeatherOverview(city) { [weak self](weatherOverview) in
			guard let weatherOverview = weatherOverview else {
				UIAlertController.showAlert("Something went wrong 😞", completion: nil)
				self?.citySelcetion = .none
				return
			}
			self?.updateCitySelectionOptionUI()
			self?.weatherOverview = weatherOverview
		}
	}
	
	
	// MARK: - Methods IBActions -
	
	@IBAction func currentBarButtonTapped(_ sender: UIBarButtonItem) {
		self.showWeatherOverviewForCurrentCity()
	}
	
	@IBAction func mapBarButtonTapped(_ sender: UIBarButtonItem) {
		self.showMapViewController()
	}
}


// MARK: - CLLocationManagerDelegate -

extension WeatherOverviewViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		location.getCity { (city) in
			guard let city = city else { return }
			guard let currentCity = self.currentCity else {
				self.currentCity = city
				self.citySelcetion = .current(city: city)
				return
			}
			guard currentCity != city else { return }
			self.currentCity = city
			guard self.citySelcetion.isCurrent else { return }
			self.citySelcetion = .current(city: city)
			self.updateCitySelectionOption()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.clAuthorizationStatus = status
	}
}


// MARK: - SearchButtonContainerDelegate -

extension WeatherOverviewViewController: SearchButtonContainerDelegate {
	func didTapSearchButton() {
		self.showApplePlacesViewController()
	}
}


// MARK: - ApplePlacesViewControllerDelegate -

extension WeatherOverviewViewController: ApplePlacesViewControllerDelegate {
	func didSelectCity(city: City) {
		self.citySelcetion = .autocomplete(city: city)
	}
}


// MARK: - MapViewControllerDelegate -

extension WeatherOverviewViewController: MapViewControllerDelegate {
	func didSelectCity(_ city: City) {
		self.citySelcetion = .map(city: city)
	}
}
