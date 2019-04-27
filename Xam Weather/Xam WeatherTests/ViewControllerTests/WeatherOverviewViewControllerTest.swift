//
//  WeatherOverviewViewController.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class WeatherOverviewViewControllerTest: XCTestCase {
	private var weatherOverviewViewController: WeatherOverviewViewController!
	
	override func setUp() {
		let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
		self.weatherOverviewViewController = mainStorybord.instantiateViewController(withIdentifier: String(describing: WeatherOverviewViewController.self)) as? WeatherOverviewViewController
		guard let _ = self.weatherOverviewViewController else {
			XCTFail("Can't create WeatherOverviewViewController from storyboard.")
			return
		}
	}
	
	
	// MARK: - Tests -
	
	func testWeatherOverviewViewController() {
		XCTAssert(self.weatherOverviewViewController != nil, "Can't create WeatherOverviewViewController from storyboard.")
	}
}
