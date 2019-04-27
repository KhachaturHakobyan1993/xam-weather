//
//  ApplePlacesViewControllerTest.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class ApplePlacesViewControllerTest: XCTestCase {
	private var applePlacesViewController: ApplePlacesViewController!
	
	override func setUp() {
		let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
		self.applePlacesViewController = mainStorybord.instantiateViewController(withIdentifier: String(describing: ApplePlacesViewController.self)) as? ApplePlacesViewController
		guard let _ = self.applePlacesViewController else {
			XCTFail("Can't create ApplePlacesViewController from storyboard")
			return
		}
	}
	
	
	// MARK: - Tests -
	
	func testWeatherOverviewViewController() {
		XCTAssert(self.applePlacesViewController != nil, "Can't create ApplePlacesViewController from storyboard.")
	}
	
	func testDelegate() {
		XCTAssert(self.applePlacesViewController.delegate == nil, "ApplePlacesViewControllerDelegate must be nil.")
	}
}
