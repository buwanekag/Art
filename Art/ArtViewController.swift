//
//  ArtViewController.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 4/5/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ArtViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    
    
    
    
    var backendless = Backendless.sharedInstance()
    let locationManager = CLLocationManager()
    
    
 //MARK: - Interactive Method 
    
    
    
    func createLocationPoint() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
    }
    
    
    //MARK: - Location Delegate Methods
    

                // Saving current location
    
    
                func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let location = locations.last
                let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                self.mapView.setRegion(region, animated: true)
        
                self.locationManager.stopUpdatingLocation()

        
                    // Saving Geo Point in Backendless

                   // func addGeoPoint(){
                    
                    let currentLocation = GeoPoint.geoPoint(
                        
                    GEO_POINT(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude),
            
                    categories: ["Places"],
                        metadata: ["Message":"\(messageTextView.text)"]
                    ) as! GeoPoint
        
                    
                        backendless.geoService.savePoint(
                    currentLocation,
                        response: { (let point:GeoPoint!) -> () in
                            print("Async: geo point saved.Object ID - \(point.objectId)")
        
                        },
                        error: { (let fault : Fault!) -> () in
                            print("Server reported an error: \(fault)")
                        }
                    
                    
                    
                    )
                    //}
                    

        
        
        }
        
    
    
    
    
    
    //MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.createLocationPoint()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaveMarkButtonPressed(sender:UIButton){
        self.createLocationPoint()
    }
    
   // override func viewDidAppear(animated: Bool) {
//        
//        if (backendless.userService.isStayLoggedIn){
//        (backendless.userService.setStayLoggedIn(true))
//            
//        } else{
        
      //  backendless.userService.currentUser.i
        
        //let userToken = backendless.userService.currentUser.getUserToken()
        
        //func validUserToken() {
//            backendless.userService.isValidUserToken(
//                { ( result : AnyObject!) -> () in
//                    print("isValidUserToken (ASYNC): \(result.boolValue)")
//                    self.backendless.userService.setStayLoggedIn( true )
//                    //self .SegueForLoggedInUser()
//                    
//                    
//                },
//                error: { ( fault : Fault!) -> () in
//                    print("Server reported an error (ASYNC): \(fault)")
//                }
//            )
//        }
       
        //if backendless.userService.
       // self.performSegueWithIdentifier("loginView", sender: self)
//        //}
    //}


    
}
