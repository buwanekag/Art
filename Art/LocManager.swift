//
//  LocManager.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 6/15/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class LocManager: NSObject,CLLocationManagerDelegate{
    
    static let sharedInstance = LocManager()
    
    let locationManager = CLLocationManager()
    
    func displayLocationPoint() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        //self.mapView.showsUserLocation = true
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
       // self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }


    





}
