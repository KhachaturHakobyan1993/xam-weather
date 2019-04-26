//
//  WeatherSecondHeaderCellCollectionViewCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class WeatherSecondHeaderCell: UICollectionViewCell {
	
	lazy var cellCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsHorizontalScrollIndicator = false
		cv.delegate = self
		return cv
	}()
	
	let topSeparator = SeparationLineView()
	let bottomSeparator = SeparationLineView()
	
	 var datasourceItem: Any? {
		didSet{
//			guard let weatherHourly = datasourceItem as? [WeatherHourly] else {
//				return
//			}
//			let datasource = HourlyWeatherDatasource(weatherHourly: weatherHourly)
//			cellCollectionView.datasource = datasource
		}
	}
	
	 func setupViews() {
		self.addSubview(self.cellCollectionView)
		self.addSubview(self.topSeparator)
		self.addSubview(self.bottomSeparator)
		
		self.cellCollectionView.fillSuperview()
		
		self.topSeparator.anchorToTop(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
		self.topSeparator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
		
		self.bottomSeparator.anchorToTop(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
		self.bottomSeparator.heightAnchor.constraint(equalToConstant:  1 / UIScreen.main.scale).isActive = true
	}
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension WeatherSecondHeaderCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 42, height: frame.height - 20)
	}
}
