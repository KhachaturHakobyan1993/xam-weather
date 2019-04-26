//
//  ExtendedInfoCell.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class ExtendedInfoCell: UICollectionViewCell {
	
	lazy var cellCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.sectionInset = UIEdgeInsets(top: 0, left: GlobalConstant.margin, bottom: 0, right: GlobalConstant.margin)
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.isScrollEnabled = false
		cv.delegate = self
		return cv
	}()
	
	var datasourceItem: Any? {
		didSet{
//			guard let weatherExtendedInfo = datasourceItem as? WeatherExtendedInfo else { return }
//			let extendedInfoDatasource = ExtendedInfoDatasource(weatherExtendedInfo: weatherExtendedInfo)
//			cellCollectionView.datasource = extendedInfoDatasource
		}
	}
	
	 func setupViews() {
		self.addSubview(self.cellCollectionView)
		self.cellCollectionView.fillSuperview()
	}
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension ExtendedInfoCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExtendedDetailCell.self), for: indexPath) as? ExtendedDetailCell else { return UICollectionViewCell() }
		return cell
	}
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension ExtendedInfoCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: (frame.width - 2 * GlobalConstant.margin) / 2, height: WeatherCells.extendedInfo.defaultHeight)
	}
}
