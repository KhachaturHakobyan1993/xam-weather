//
//  Xam_WeatherUITests.swift
//  Xam WeatherUITests
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest

class Xam_WeatherUITests: XCTestCase {
	private var app: XCUIApplication!
	
	
	override func setUp() {
		super.setUp()
		self.continueAfterFailure = false
		self.app = XCUIApplication()
	}
	
	
	// MARK: - Tests -
	
	func testGoingMapViewController() {
		self.app.launch()
		XCTAssertTrue(self.app.isDisplayingWeatherOverviewViewController)
		self.app.navigationBars["Xam_Weather.WeatherOverviewView"]
			.children(matching: .button).element(boundBy: 1)
			.tap()
		XCTAssertTrue(self.app.isDisplayingMapViewController)
	}
	
	func testGoingApplePlacesViewController() {
		self.app.launch()
		XCTAssertTrue(self.app.isDisplayingWeatherOverviewViewController)
		XCUIApplication().otherElements["Xam_Weather.WeatherOverviewViewController"]
			.children(matching: .other).element.children(matching: .other).element
			.children(matching: .other).element.children(matching: .button).element
			.tap()
		XCTAssertTrue(self.app.isDisplayingApplePlacesViewController)
	}
}


// MARK: - Displaying Names Of UIViewControllers -

extension XCUIApplication {
	var isDisplayingWeatherOverviewViewController: Bool {
		return self.otherElements["Xam_Weather.WeatherOverviewViewController"].exists
	}
	
	var isDisplayingMapViewController: Bool {
		return self.otherElements["Xam_Weather.MapViewController"].exists
	}
	
	var isDisplayingApplePlacesViewController: Bool {
		return self.otherElements["Xam_Weather.ApplePlacesViewController"].exists
	}
}
