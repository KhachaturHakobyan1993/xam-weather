//
//  MKLocalSearchCompletion+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import MapKit

extension MKLocalSearchCompletion {
	func getCity(_ completion: @escaping ((_ city: String?) -> Void)) {
		let searchRequest = MKLocalSearch.Request(completion: self)
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
			guard let response = response,
				error == nil,
				let placeMark = response.mapItems.first?.placemark,
				let city = placeMark.locality else { completion(nil); return }
			completion(city)
		}
	}
}
