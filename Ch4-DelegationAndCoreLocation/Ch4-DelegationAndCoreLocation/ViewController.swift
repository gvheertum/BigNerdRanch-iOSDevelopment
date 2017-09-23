//
//  ViewController.swift
//  Ch4-DelegationAndCoreLocation
//
//  Created by Gertjan on 22/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit
import CoreLocation
//Hmmmm, this thing refuses to work correctly in the simulator and will either crash or not response to changes in the delegate.
//Well, whatever, we know the idea behind the delegates and stuff.

class ViewController: UIViewController
{

	var locationManager : CLLocationManager?;
	var locationManagerDelegate : CLLocationManagerDelegateResponder?;
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder);
		locationManager = CLLocationManager();
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
		NSLog("Service enabled: \(CLLocationManager.locationServicesEnabled())");
		locationManagerDelegate = CLLocationManagerDelegateResponder();
		locationManager?.delegate = self.locationManagerDelegate;
		locationManager?.startUpdatingLocation();
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

class CLLocationManagerDelegateResponder : NSObject, CLLocationManagerDelegate
{
	/*func locationManager(_ manager : CLLocationManager, didUpdateTo: CLLocation, from: CLLocation)
	{
		NSLog("Moved from \(from) to \(didUpdateTo)");
	}*/
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		NSLog("Updated locations");
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
	{
		NSLog("Could not process location: \(error)");
	}
}
