//
//  URL+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/27/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation

extension URL {
	func withQueries(_ queries: [String: String]) -> URL? {
		var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
		components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
		return components?.url
	}
}
