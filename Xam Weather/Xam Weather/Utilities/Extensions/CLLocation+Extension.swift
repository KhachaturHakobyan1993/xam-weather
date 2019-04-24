//
//  CLLocation+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import CoreLocation

extension CLLocation {
	func getCity(_ completion: @escaping ((_ city: String?) -> Void)) {
		let ceo = CLGeocoder()
		ceo.reverseGeocodeLocation(self) { (placemarks, error) in
			guard let placemark = placemarks?.first,
				let city = placemark.locality else { completion(nil); return }
			completion(city)
		}
	}
}
