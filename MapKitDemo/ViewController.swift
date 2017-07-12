//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Rajat Bhatt on 11/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var searchMap: UISearchBar!
    
    //MARK: Properties
    let locationManager = CLLocationManager()
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMap.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//MARK: Search Bar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMap.resignFirstResponder()
        print("Searching... \(searchBar.text ?? "Nothing")")
        let geoCoder = CLGeocoder()
        if let searchString = searchBar.text, !searchString.isEmpty {
            geoCoder.geocodeAddressString(searchString) { (placemarks, error) in
                if error == nil {
                    let placemark = placemarks?.first
                    print("Location:--------------\n",placemark ?? "No Placemark")
                    let distance: CLLocationDistance = 1000
                    if let location = placemark?.location {
                        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(location.coordinate, distance, distance), animated: true)
                        let locationPin = MyAnnotation(title: searchString, subtitle: "", coordinate: location.coordinate)
                        self.mapView.addAnnotation(locationPin)
                    } else {
                        print(error?.localizedDescription ?? "error")
                    }
                }
            }
        }
    }
}

//MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                print(placemarks?.first ?? "No place to reversegeocode")
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
        print("Location:--------------\n",location)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
}
