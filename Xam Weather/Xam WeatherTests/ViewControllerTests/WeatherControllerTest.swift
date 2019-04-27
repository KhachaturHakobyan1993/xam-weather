//
//  WeatherControllerTest.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class WeatherControllerTest: XCTestCase {
	private var weatherController = WeatherController()
	
	
	// MARK: - Tests -
	
	func testCollectionView() {
		guard let _ = self.weatherController.collectionView else { return }
		XCTFail("Collection View Isn't Nil.")
	}
	
	func testWeatherOverviewModel() {
		guard let _ = self.weatherController.weatherOverview else { return }
		XCTFail("WeatherOverview Model Isn't Nil.")
	}
}
