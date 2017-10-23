//
//  MapViewController.swift
//  SimpleHotels
//
//  Created by Mark Kuharich on 10/22/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import UIKit
import MapKit


class HotelAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
    init(_ name: String, _ latitude: Double, _ longitude: Double) {
        super.init()
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        title = name
    }
    var title: String?
}

class MapViewController: UIViewController, MKMapViewDelegate {

	var hotelDetails: Hotel?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationController?.isNavigationBarHidden = false
        guard let hotelDetails = hotelDetails else {
            return
        }
        let coordinates = CLLocationCoordinate2DMake(hotelDetails.latitude, hotelDetails.longitude)
        let region = MKCoordinateRegionMakeWithDistance(coordinates, 3000, 3000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(HotelAnnotation(hotelDetails.name, hotelDetails.latitude, hotelDetails.longitude))
    }
}
