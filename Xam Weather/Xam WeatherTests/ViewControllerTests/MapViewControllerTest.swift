//
//  MapViewControllerTest.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class MapViewControllerTest: XCTestCase {
	private var mapViewController: MapViewController!
	
	override func setUp() {
		let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
		self.mapViewController = mainStorybord.instantiateViewController(withIdentifier: String(describing:  MapViewController.self)) as?  MapViewController
		guard let _ = self.mapViewController else {
			XCTFail("Can't create MapViewController from storyboard")
			return
		}
	}
	
	
	// MARK: - Tests -
	
	func testWeatherOverviewViewController() {
		XCTAssert(self.mapViewController != nil, "Can't create MapViewController from storyboard.")
	}
	
	func testDelegate() {
		XCTAssert(self.mapViewController.delegate == nil, "MapViewControllerDelegate must be nil.")
	}
}
