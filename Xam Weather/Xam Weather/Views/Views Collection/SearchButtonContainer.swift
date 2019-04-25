//
//  SearchButtonContainer.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/24/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

protocol SearchButtonContainerDelegate: NSObjectProtocol {
	func didTapSearchButton()
}

final class SearchButtonContainer: NibBasedCustomView {
    @IBOutlet private weak var searchButton: SearchButton!
	@IBOutlet private weak var searchImage: UIImageView!
	weak var delegate: SearchButtonContainerDelegate?
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.setup()
	}
	
	
	// MARK: - Methods Setup -

	private func setup() {
		self.searchButton.addTarget(self, action: #selector(SearchButtonContainer.searchButtonTapped), for: .touchUpInside)
	}
	
	@objc private func searchButtonTapped() {
		self.delegate?.didTapSearchButton()
	}

	
	// MARK: - Methods -
	
    func updateSearchTitle(_ title: String) {
        guard title != "" else {
            self.searchButton.locationLabel.text = "Search City"
            self.searchButton.locationLabel.sizeToFit()
            return
        }
        self.searchButton.locationLabel.text = title
        self.searchButton.locationLabel.sizeToFit()
		self.searchButton.setUpAnimation()
    }
	
	func setSearchImage(_ image: UIImage) {
		self.searchImage.image = image
	}
}

