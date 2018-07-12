//
//  ViewController.swift
//  geo locater
//
//  Created by Ankit Malik on 12/07/18.
//  Copyright © 2018 Ankit Malik. All rights reserved.
//

import UIKit
import  CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       var userLocation:CLLocation = locations[0]
        
       self.latitudeLabel.text = String(userLocation.coordinate.latitude)
       self.longitudeLabel.text = String(userLocation.coordinate.longitude)
       self.courseLabel.text = String(userLocation.course)
       self.speedLabel.text = String(userLocation.speed)
       self.altitudeLabel.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil{
                print(error!)
            }
            else {
                if let placemark = placemarks?[0] {
                    
                    var subThroughFare = ""
                    if placemark.subThoroughfare != nil {
                        subThroughFare = placemark.subThoroughfare!
                    }
                    var thoroughFare = ""
                    if placemark.thoroughfare != nil{
                        thoroughFare = placemark.thoroughfare!
                    }
                    var subLocality = ""
                    if placemark.subLocality != nil{
                        subLocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = ""
                    if placemark.country != nil{
                        country = placemark.country!
                    }
                    self.locationLabel.text = String(subThroughFare + thoroughFare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

