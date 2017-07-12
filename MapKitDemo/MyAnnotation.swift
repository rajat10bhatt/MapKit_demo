//
//  MyAnnotation.swift
//  MapKitDemo
//
//  Created by Rajat Bhatt on 11/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
