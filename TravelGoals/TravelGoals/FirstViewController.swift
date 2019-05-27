//
//  FirstViewController.swift
//  TravelGoals
//
//  Created by Manoj Bandara on 25/5/19.
//  Copyright © 2019 Manoj Bandara. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinsubtitle:String,  loction:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.coordinate = loction
        self.subtitle = pinsubtitle
    }
}


class FirstViewController: UIViewController, MKMapViewDelegate {

    var tripArray = [Trip]()
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        //self.map.reload()
        // Do any additional setup after loading the view, typically from a nib.
        //let address = "Australia"
        tripArray = readJson()
        loadTrip(array: tripArray)
        

    }
    
    @IBAction func refresh(_ sender: Any) {
        var tripsArray = readJson()
        loadTrip(array: tripsArray)
    }
    
    
    func loadTrip(array: [Trip]) {
        self.map.camera.altitude = 1000000000.0
        
        for trip in array {
            
            getCoordinate(address: trip.country) { (coordinate, location, error) in
                if let coordinate = coordinate {
                    let pin : customPin?
                    
                    self.map.camera.centerCoordinate = coordinate
                    
                    if(trip.isCompleted == 1) {
                        pin  = customPin(pinTitle: trip.country, pinsubtitle: "completed", loction: coordinate)
                    } else {
                        pin  = customPin(pinTitle: trip.country, pinsubtitle: "not completed", loction: coordinate)
                    }
                    
                    //let pin =  customPin(pinTitle: trip.country, loction: coordinate)
                    self.map.addAnnotation(pin!)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       
        let annotationView = MKPinAnnotationView()
        
        if annotation.subtitle == "completed" {
            annotationView.pinTintColor = UIColor.green
        } else {
            annotationView.pinTintColor = UIColor.blue
        }

        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCoordinate( address:String, completionHandler: @escaping (CLLocationCoordinate2D?,String,NSError?)->Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) {(placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let coordinate = placemark.location?.coordinate
                    //let location = placemark.locality! + " " + placemark.isoCountryCode!
                    completionHandler(coordinate, address, nil)
                    return
                }
            }
            completionHandler(nil, "", error as NSError?)
        }
    }


}

