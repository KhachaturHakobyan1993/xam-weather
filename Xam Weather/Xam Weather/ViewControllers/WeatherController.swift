//
//  WeatherController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
	var collectionView: UICollectionView! = nil
	private let headerCells: [UICollectionViewCell.Type] = [WeatherTopHeaderCell.self, WeatherSecondHeaderCell.self]
	private let cells: [UICollectionViewCell.Type] = [WeatherCell.self]
	var weatherOverview: WeatherOverview! {didSet{self.collectionView.reloadData()}}
	
	private let backgroundImageView: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "imageBlueSkyBackground")
		iv.clipsToBounds = true
		return iv
	}()
	
	let errorMessageLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18)
		label.text = "Sorry, something went wrong. Please try again later..."
		label.textAlignment = .center
		label.numberOfLines = 0
		label.isHidden = true
		return label
	}()
	
	let activityIndicatorView: UIActivityIndicatorView = {
		let aiv = UIActivityIndicatorView(style: .whiteLarge)
		aiv.hidesWhenStopped = true
		aiv.color = .white
		return aiv
	}()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupActivityIndicator()
		self.setupErrorMessageLabel()
		self.setupCollectionView()
    }
	
	
	// MARK: - Methods Setup -

	private func setupActivityIndicator() {
		self.view.addSubview(self.activityIndicatorView)
		self.activityIndicatorView.anchorCenterXToSuperview()
		self.activityIndicatorView.anchorCenterYToSuperview()
	}
	
	private func setupErrorMessageLabel() {
		self.view.addSubview(self.errorMessageLabel)
		self.errorMessageLabel.anchorCenterSuperview()
		self.errorMessageLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
		self.errorMessageLabel.equalHeightToWidth()
	}
	
	private func setupCollectionView() {
		self.collectionView.collectionViewLayout = WeatherCollectionViewFlowLayout()
		self.collectionView.backgroundView = self.backgroundImageView
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionView.alwaysBounceVertical = true
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		for headerClass in self.headerCells {
			self.collectionView.register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(headerClass))
		}
		for cellClass in self.cells {
			self.collectionView.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
		}
	}
}


// MARK: - UICollectionViewDelegate -

extension WeatherController: UICollectionViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let headerHeightMaxChange = WeatherHeaders.topHeader.defaultHeight - WeatherHeaders.topHeader.minimumHeight
		var subOffset: CGFloat = 0
		if offsetY > headerHeightMaxChange {
			subOffset = offsetY - headerHeightMaxChange
		} else {
			subOffset = 0
		}
		NotificationCenter.default.post(name: Notification.Name(rawValue: "setOffset"), object: subOffset)
	}
}


// MARK: - UICollectionViewDataSource -

extension WeatherController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return (self.weatherOverview == nil ? 0 : self.headerCells.count)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return (section == WeatherHeaders.topHeader.section ? 0 : self.cells.count)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(WeatherCell.self), for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
		cell.backgroundColor = UIColor(named: "lightBlue")!
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionViewCell() }
		var reusableView = UICollectionViewCell()
		
		switch indexPath.section {
		case WeatherHeaders.topHeader.section:
			guard let topHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(WeatherTopHeaderCell.self), for: indexPath) as? WeatherTopHeaderCell else { return reusableView }
			topHeaderCell.datasourceItem = self.weatherOverview
			reusableView = topHeaderCell
		case WeatherHeaders.centerHeader.section:
			guard let secondHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(WeatherSecondHeaderCell.self), for: indexPath) as? WeatherSecondHeaderCell else { return reusableView }
			secondHeaderCell.datasourceItem = self.weatherOverview.list
			reusableView = secondHeaderCell
		default: break
		}
		return reusableView
	}
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension WeatherController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.width, height: 720)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		let topHeaderSize = CGSize(width:view.frame.width, height: WeatherHeaders.topHeader.defaultHeight)
		let secondHeaderSize = CGSize(width:view.frame.width, height: WeatherHeaders.centerHeader.defaultHeight)
		return (section == WeatherHeaders.topHeader.section ? topHeaderSize : secondHeaderSize)
	}
}

