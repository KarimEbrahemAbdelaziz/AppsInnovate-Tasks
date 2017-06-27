//
//  ViewController.swift
//  MyMapApp
//  In this project i used MapKit and CoreLocation to handle my location and random locations
//      in another project i used Google Maps SDK :)
//  Created by KARIM on 6/26/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!

    let locationManager = CLLocationManager()
    var location = CLLocation()
    var placePin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
    }
    
    @IBAction func getMyLocation(_ sender: UIButton) {
        let span = MKCoordinateSpanMake(0.08, 0.08)
        let myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegionMake(myLocation, span)
        
        myMapView.setRegion(region, animated: true)
        
        myMapView.showsUserLocation = true
    }
    
    @IBAction func generateNewLocation(_ sender: UIButton) {
        myMapView.removeAnnotation(placePin)
        let span = MKCoordinateSpanMake(2, 2)
        let myLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(randomBetweenNumbers(firstNum: 22, secondNum: 29.698099)), longitude: CLLocationDegrees(randomBetweenNumbers(firstNum: 31.674179, secondNum: 33.89468)))
        let region = MKCoordinateRegionMake(myLocation, span)
        myMapView.setRegion(region, animated: true)
        
        placePin.coordinate = myLocation
        placePin.title = "My Random Place"
        placePin.subtitle = "it's just for me to test :D"
        myMapView.addAnnotation(placePin)
        
        print(myLocation.latitude)
        print(myLocation.longitude)
    }
    
    func randomBetweenNumbers(firstNum: Float, secondNum: Float) -> Float{
        return Float(arc4random()) / Float(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

