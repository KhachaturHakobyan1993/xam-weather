//
//  Xam_WeatherTests.swift
//  Xam WeatherTests
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import XCTest
@testable import Xam_Weather

class Xam_WeatherTests: XCTestCase {

	func testDateExtension() {
		let stringDate = "2019/04/27"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy/MM/dd"
		let date = dateFormatter.date(from: stringDate)!
		let weekDay = date.dayOfWeek()
		XCTAssert("Saturday" == weekDay, "'dayOfWeek' function does'not work")
	}
	
	func testCLLocationExtension() {
		let yerevan = City(name: "Yerevan", location: .init(latitude: 40.155309, longitude: 44.497499))
		var city: City! = nil
		let errorExpectation = self.expectation(description: "error")
		
		yerevan.location.getCity { (_city) in
			city = _city
			errorExpectation.fulfill()
		}
	
		self.waitForExpectations(timeout: 2) { (_) in
			XCTAssertEqual(yerevan, city, "'getCity' function does'not work")
		}
	}
}
