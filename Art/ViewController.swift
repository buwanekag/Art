//
//  ViewController.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 3/31/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageDisplay: UITextView!
    @IBOutlet weak var messageDisplayLabel: UILabel!
    
    
    
    
    
    var backendless = Backendless.sharedInstance()
    var locManager = LocManager.sharedInstance
    
    let locationManager = CLLocationManager()
    
    func displayLocationPoint() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    
    //MARK: - Location Delegate Methods
    
    
    
    
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last
            let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
            self.mapView.setRegion(region, animated: true)
            self.locationManager.stopUpdatingLocation()
        
            //Get geo points from Backendless
            
            let query = BackendlessGeoQuery.query(with: GEO_POINT(latitude: location!.coordinate.latitude,longitude: location!.coordinate.longitude),radius: 0.2,units: MILES,categories: ["Places"]) as! BackendlessGeoQuery
        
            query.includeMeta = true
        3
        backendless.geoService.getPoints(
        
            query,
        response: { (points : BackendlessCollection!) -> () in
            self.nextPageAsync(points)
            print("\(query)")
            },
        error: { (fault: Fault!) -> () in
            print("server reported an error: \(fault)")
            
            }
        )
    }
   
        func nextPageAsync(_ points: BackendlessCollection) {
            
            if points.getCurrentPage().count == 0 {
    
                return
            }
            
            
            
            let geoPoints = points.getCurrentPage() as! [GeoPoint]
            for geoPoint in geoPoints {
                
                //geoPoint.
                //geoPoint.distance.rangeValue.length
                if geoPoint.distance.intValue <= 5 {
                
                
                self.messageDisplay.text = geoPoint.metadata.value(forKey: "Message") as? String
                
               print("\(geoPoint.metadata)")
            
                }else{
                    self.messageDisplay.text = "No Messages here yet, be the first to Graphiti here"
                }
                
            }
            
            points.nextPageAsync(
                { (rest : BackendlessCollection!) -> () in
                    self.nextPageAsync(rest)
                },
                error: { (fault : Fault!) -> () in
                    print("Server reported an error: \(fault)")
                }
            )
        }

    
    
    

    
    //MARK:- Life Cycle Method
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.displayLocationPoint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        self.displayLocationPoint()
    }


}

