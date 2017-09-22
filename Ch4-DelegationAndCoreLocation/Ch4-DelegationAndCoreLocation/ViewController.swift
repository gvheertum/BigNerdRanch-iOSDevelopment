//
//  ViewController.swift
//  Ch4-DelegationAndCoreLocation
//
//  Created by Gertjan on 22/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController
{

	var locationManager : CLLocationManager?;
	//TODO: This is not called, ??
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
	{
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
		locationManager = CLLocationManager();
		locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
		locationManager?.startUpdatingLocation();
		NSLog("Application started");
		print("hoi!");
	}
	
	required init?(coder aDecoder: NSCoder!)
	{
		super.init(coder: aDecoder)
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

