//
//  WeatherAllCitiesViewController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

protocol WeatherAllCitiesViewControllerDelegate: NSObjectProtocol {
	func didSelectCityWeatherAllCities(_ city: City)
}

class WeatherAllCitiesViewController: UIViewController {
	@IBOutlet private weak var tableView: UITableView!
	private var allCities = [WeatherCityViewModel]()
	weak var delegate: WeatherAllCitiesViewControllerDelegate?
	
	static func instantiateFromStoryboard() -> WeatherAllCitiesViewController? {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let identifier = String(describing: WeatherAllCitiesViewController.self)
		guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? WeatherAllCitiesViewController else { return nil }
		return controller
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	
	// MARK: - Methods IBActions -
	
	@IBAction func buttonCancelTapped(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate -

extension WeatherAllCitiesViewController: UICollectionViewDataSource & UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return WeatherCity.allCities.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CityCell.self), for: indexPath) as? CityCell else { return UICollectionViewCell() }
		let city = WeatherCity.allCities[indexPath.row]
		let cityViewModel = WeatherCityViewModel(weatherCity: city)
		cell.city = cityViewModel
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let city = WeatherCity.allCities[indexPath.row]
		let cityViewModel = WeatherCityViewModel(weatherCity: city)
		cityViewModel.convertToCity {
			self.tableView.beginUpdates()
			self.allCities.insert(cityViewModel, at: 0)
			self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
			self.tableView.endUpdates()
		}
	}
}


// MARK: - UITableViewDataSource & UITableViewDelegate -

extension WeatherAllCitiesViewController: UITableViewDataSource & UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.allCities.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityTimeZoneCell.self), for: indexPath) as? CityTimeZoneCell else { return UITableViewCell() }
		cell.city = self.allCities[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		self.allCities.remove(at: indexPath.row)
		self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let weatherCity = self.allCities[indexPath.row]
		guard let city = weatherCity.convertedCity else { return }
		self.dismiss(animated: true, completion: nil)
		self.delegate?.didSelectCityWeatherAllCities(city)
	}
}
