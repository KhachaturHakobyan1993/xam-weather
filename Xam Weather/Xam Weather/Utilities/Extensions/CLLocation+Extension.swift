//
//  CLLocation+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import CoreLocation

extension CLLocation {
	func getCity(_ completion: @escaping ((_ city: City?) -> Void)) {
		let ceo = CLGeocoder()
		ceo.reverseGeocodeLocation(self) { (placemarks, error) in
			guard let placemark = placemarks?.first,
				let cityName = placemark.locality,
			let location = placemark.location else { completion(nil); return }
			let city = City.init(name: cityName, location: location)
			completion(city)
		}
	}
	
	func getTimeZone(_ completion: @escaping (TimeZone?) -> Void ) {
		let ceo = CLGeocoder()
		ceo.reverseGeocodeLocation(self) { (placemarks, error) in
			guard let placemark = placemarks?.first,
				let timeZone = placemark.timeZone else { completion(nil); return }
			completion(timeZone)
		}
	}
}
