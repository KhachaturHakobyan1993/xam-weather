//
//  ApplePlacesViewController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import MapKit

protocol ApplePlacesViewControllerDelegate: NSObjectProtocol {
	func didTapCity(city: String)
}

class ApplePlacesViewController: UIViewController {
	@IBOutlet weak var searchResultsTableView: UITableView!
	private var searchResults = [MKLocalSearchCompletion]()
	lazy var searchCompleter: MKLocalSearchCompleter = {
		let sCompleter = MKLocalSearchCompleter()
		sCompleter.delegate = self
		sCompleter.region = MKCoordinateRegion()
		return sCompleter
	}()
	weak var delegate: ApplePlacesViewControllerDelegate?
	
	static func instantiateFromStoryboard() -> ApplePlacesViewController? {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let identifier = String(describing: ApplePlacesViewController.self)
		guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ApplePlacesViewController else { return nil }
		return controller
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setup()
	}
	
	
	// MARK: - Methods Setup -

	private func setup() {
		self.searchResultsTableView.tableFooterView = UIView()
		let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
	}
}


// MARK: -  UISearchBarDelegate

extension ApplePlacesViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.searchCompleter.queryFragment = searchText
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.view.endEditing(true)
		self.dismiss(animated: true, completion: nil)
	}
}


// MARK: -  UITableViewDataSource & UITableViewDelegate

extension ApplePlacesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.searchResults.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		let searchResult = self.searchResults[indexPath.row]
		cell.textLabel?.text = searchResult.title
		cell.detailTextLabel?.text = searchResult.subtitle
		cell.detailTextLabel?.textColor = UIColor.lightGray
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let completion = self.searchResults[indexPath.row]
		completion.getCity { (city) in
			guard let city = city else {
				self.showAlert("City not found!", completion: nil)
				return
			}
			self.delegate?.didTapCity(city: city)
			self.view.endEditing(true)
			self.dismiss(animated: true, completion: nil)
		}
	}
}


// MARK: - MKLocalSearchCompleterDelegate

extension ApplePlacesViewController: MKLocalSearchCompleterDelegate {
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		self.searchResults = completer.results
		DispatchQueue.main.async {
			self.searchResultsTableView.reloadData()
		}
	}
	
	func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
		debugPrint(error.localizedDescription)
	}
}

