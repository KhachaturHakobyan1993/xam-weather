//
//  MKLocalSearchCompletion+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import MapKit

extension MKLocalSearchCompletion {
	func getCity(_ completion: @escaping ((_ city: City?) -> Void)) {
		let searchRequest = MKLocalSearch.Request(completion: self)
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
			guard let response = response,
				error == nil,
				let placeMark = response.mapItems.first?.placemark,
				let cityName = placeMark.locality,
				let location = placeMark.location else { completion(nil); return }
			let city = City.init(name: cityName, location: location)
			completion(city)
		}
	}
}
