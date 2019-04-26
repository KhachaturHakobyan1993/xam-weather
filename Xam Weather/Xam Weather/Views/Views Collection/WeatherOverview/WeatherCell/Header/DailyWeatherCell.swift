//
//  DailyWeatherCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {
	
	lazy var cellCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 0
		layout.sectionInset = UIEdgeInsets(top: 10, left: GlobalConstant.margin, bottom: 0, right: GlobalConstant.margin)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.delegate = self
		cv.isScrollEnabled = false
		return cv
	}()
	
	let separatorLineView: UIView = {
		let lineView = UIView()
		lineView.backgroundColor = UIColor(white: 0, alpha: 0.5)
		lineView.isHidden = true
		return lineView
	}()
	
	 var datasourceItem: Any? {
		didSet{
//			guard let dailyWeather = datasourceItem as? [WeatherDaily] else {
//				return
//			}
//			setDatasource(dailyWeather: dailyWeather)
		}
	}
	
	 func setupViews() {
		self.addSubview(self.cellCollectionView)
		self.addSubview(self.separatorLineView)
		self.cellCollectionView.fillSuperview()
		self.separatorLineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
		self.separatorLineView.isHidden = false
	}
	

	fileprivate func setDatasource(dailyWeather: [WeatherOverview]) {
//		let dailyWeatherDatasource = DailyWeatherDatasource(dailyWeather: dailyWeather)
//		cellCollectionView.datasource = dailyWeatherDatasource
	}
}


// MARK: - UICollectionViewDataSource -

extension DailyWeatherCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DailyDetailCell.self), for: indexPath) as? DailyDetailCell else { return UICollectionViewCell() }
		return cell
	}
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension DailyWeatherCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width - 2 * GlobalConstant.margin, height: 30)
	}
}


