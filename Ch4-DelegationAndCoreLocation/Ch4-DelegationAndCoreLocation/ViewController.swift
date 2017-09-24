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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate

{

	var locationManager : CLLocationManager?;
	
	@IBOutlet var mapView : MKMapView?;
	@IBOutlet var activityIndicator : UIActivityIndicatorView?;
	@IBOutlet var locationTextField : UITextField?;
	@IBOutlet var typeSeg: UISegmentedControl?;
	
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder);
		locationManager = CLLocationManager();
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager?.requestWhenInUseAuthorization();
		print("Location service enabled: \(CLLocationManager.locationServicesEnabled())");
		
		
		locationManager?.delegate = self;
		mapView?.delegate = self;
		locationTextField?.delegate = self;

		//This is also a way to set a target, investigate
		//typeSeg?.addTarget(self, action: "action:", for: .valueChanged);
		
		// Do any additional setup after loading the view, typically from a nib.
		mapView?.showsUserLocation = true;
		
		//
		//Add the first element
		mapView?.addAnnotation(GMapPoint());
	}
	
	@IBAction func elementChanged(_ element : Any)
	{
		print("element changed");
		
		if let segmentElement = element as? UISegmentedControl
		{
			print("Changing!");
			let mType : MapType = MapType(rawValue: segmentElement.selectedSegmentIndex)!;
			setMapType(mType);
		}
	}
	
	enum MapType : Int
	{
		case Standard = 0;
		case Satellite = 1;
		case Hybrid = 2;
	}
	
	func setMapType(_ type: MapType)
	{
		switch(type)
		{
			case .Standard: mapView?.mapType = .standard;
			case .Satellite: mapView?.mapType = .satellite;
			case .Hybrid: mapView?.mapType = .hybrid;
		}
	}
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad();
		locationTextField?.delegate = self; //This refuses to work if put in the init.... If put there, the textbox will always be focussed and the return is not called...
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func findLocation()
	{
		locationManager?.startUpdatingLocation();
		activityIndicator?.startAnimating();
		locationTextField?.isHidden = true;
	}
	
	func foundLocation(_ location : CLLocation)
	{
		let coord : CLLocationCoordinate2D = location.coordinate;
		let mp : GMapPoint = GMapPoint(location: coord, title:locationTextField?.text ?? "No Text");
		mapView?.addAnnotation(mp);
		let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 25000, 25000);
		mapView?.setRegion(region, animated: true);
		
		//Loading done, stop all!
		activityIndicator?.stopAnimating();
		locationTextField?.text = "";
		locationTextField?.isHidden = false;
		locationManager?.stopUpdatingLocation();
	}
	
	
	//*** LOCATION MANAGER Delegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		let lastLoc = locations.last;
		if(lastLoc != nil && lastLoc!.timestamp.timeIntervalSinceNow > -180)
		{
			print("Set location!");
			foundLocation(lastLoc!);
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
	{
		print("Could not process location: \(error)");
	}
	
	
	//*** MAP VIEW Delegate
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
	{
		print("Mapview did update: \(userLocation)");
	}
	
	//*** UI TextFIeld delegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		findLocation();
		textField.resignFirstResponder(); //We need to resign the response, otherwise the element stays in focus
		return true;
	}
}

