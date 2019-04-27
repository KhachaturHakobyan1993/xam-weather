//
//  WeatherAllCitiesViewControllerTest.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class WeatherAllCitiesViewControllerTest: XCTestCase {
	private var weatherAllCitiesViewController: WeatherAllCitiesViewController!

	
	override func setUp() {
		let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
		self.weatherAllCitiesViewController = mainStorybord.instantiateViewController(withIdentifier: String(describing: WeatherAllCitiesViewController.self)) as? WeatherAllCitiesViewController
		guard let _ = self.weatherAllCitiesViewController else {
			XCTFail("Can't create WeatherAllCitiesViewController from storyboard")
			return
		}
	}
	
	
	// MARK: - Tests -
	
	func testWeatherOverviewViewController() {
		XCTAssert(self.weatherAllCitiesViewController != nil, "Can't create ApplePlacesViewController from storyboard.")
	}
	
	func testDelegate() {
		XCTAssert(self.weatherAllCitiesViewController.delegate == nil, "ApplePlacesViewControllerDelegate must be nil.")
	}
}
