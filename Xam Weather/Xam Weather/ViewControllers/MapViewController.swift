//
//  MapViewController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate: NSObjectProtocol {
	func didSelectCityFromMap(_ city: City)
}

final class MapViewController: UIViewController {
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var markerAddressLabel: UILabel!
	@IBOutlet weak var doneButton: UIButton!
	private var isAdd = false
	private var selectedCity: City! {didSet{self.updateMarkerAddress()}}
	private var initialCity: City?
	weak var delegate: MapViewControllerDelegate?
	
	static func instantiateFromStoryboard(initialCity: City?) -> MapViewController? {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let identifier = String(describing: MapViewController.self)
		guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? MapViewController else { return nil }
		controller.initialCity = initialCity
		return controller
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.initialSetup()
		self.setUpMapView()
		self.setUpTapGesture()
	}
	
	
	// MARK: - Methods Setup -
	
	private func initialSetup() {
		self.view.accessibilityIdentifier = NSStringFromClass(MapViewController.self)
	}
	
	private func setUpMapView() {
		self.navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
		self.mapView.delegate = self
		guard let city = self.initialCity else { return }
		self.doneButton.isHidden = false
		self.selectedCity = city
		
		let coordinateRegion = MKCoordinateRegion(center: self.selectedCity.location.coordinate,
												  latitudinalMeters: 100,
												  longitudinalMeters: 100)
		self.mapView.setRegion(coordinateRegion, animated: true)
		let annotation = MKPointAnnotation()
		annotation.coordinate = self.selectedCity.location.coordinate
		self.mapView.addAnnotation(annotation)
	}
	
	private func setUpTapGesture() {
		let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addMarker(recognizer:)))
		singleTapRecognizer.numberOfTapsRequired = 1
		singleTapRecognizer.delegate = self
		self.mapView.addGestureRecognizer(singleTapRecognizer)
	}
	
	
	// MARK: - Methods -
	
	@objc private func addMarker(recognizer: UITapGestureRecognizer ) {
		guard self.isAdd else {
			self.removeMarkers()
			return
		}
		self.removeMarkers()
		let point = recognizer.location(in: self.mapView)
		let tapPoint = self.mapView.convert(point, toCoordinateFrom: self.mapView)
		let location = CLLocation(latitude: tapPoint.latitude, longitude: tapPoint.longitude)
		location.getCity { (city) in
			guard let city = city else { return }
			self.selectedCity = city
			let annotation = MKPointAnnotation()
			annotation.coordinate = tapPoint
			self.mapView.addAnnotation(annotation)
			self.doneButton.isHidden = false
		}
	}
	
	private func removeMarkers() {
		self.doneButton.isHidden = true
		self.mapView.removeAnnotations(mapView.annotations)
		self.selectedCity = nil
	}
	
	private func updateMarkerAddress() {
		guard self.selectedCity != nil else {
			self.markerAddressLabel.text = "   Please tap on map to select address."
			self.markerAddressLabel.textColor = .lightGray
			return
		}
		self.markerAddressLabel.textColor = .black
		self.markerAddressLabel.text = "   " + self.selectedCity.name
	}
	
	
	// MARK: - Methods IBActions -
	
	@IBAction private func doneButtonTapped(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
		self.delegate?.didSelectCityFromMap(self.selectedCity)
	}
}


// MARK: - UIGestureRecognizerDelegate -

extension MapViewController: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		self.isAdd = !(touch.view?.isKind(of: MKPinAnnotationView.self))!
		return true
	}
}


// MARK: - MKMapViewDelegate -

extension MapViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		let pinAnnotationView = MKPinAnnotationView()
		pinAnnotationView.pinTintColor = UIColor.App.lightBlue.value
		return pinAnnotationView
	}
}
