//
//  ViewController.swift
//  Ch4-DelegationAndCoreLocation
//
//  Created by Gertjan on 22/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{

	var locationManager : CLLocationManager?;
	
	@IBOutlet var mapView : MKMapView?;
	@IBOutlet var activityIndicator : UIActivityIndicatorView?;
	@IBOutlet var locationTextField : UITextField?;
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder);
		locationManager = CLLocationManager();
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager?.requestWhenInUseAuthorization();
		print("Location service enabled: \(CLLocationManager.locationServicesEnabled())");
		locationManager?.startUpdatingLocation();
		locationManager?.startMonitoringSignificantLocationChanges();
		locationManager?.delegate = self;
		
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad();
		
		// Do any additional setup after loading the view, typically from a nib.
		mapView?.showsUserLocation = true;
		mapView?.delegate = self;
	
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		print("Updated locations");
		for location in locations
		{
			print("Location: \(location)");
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
	{
		print("Could not process location: \(error)");
	}
	
	func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit)
	{
		print("Visiting!");
	}
	
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
	{
		print("Mapview did update: \(userLocation)");
	}
}

