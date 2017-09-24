//
//  GMapPoint.swift
//  Ch4-DelegationAndCoreLocation
//
//  Created by Gertjan on 24/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit
import MapKit

class GMapPoint: NSObject, MKAnnotation
{
	var coordinate: CLLocationCoordinate2D
	var _title: String?;
	var title: String?
	{
		get
		{
			return _title ?? (isEast() ? "Eastern point" : "WesternPoint");
		}
	}
	
	private func isEast() -> Bool
	{
		return coordinate.longitude > 5.52;
	}
	
	init(location : CLLocationCoordinate2D, title: String)
	{
		self.coordinate = location;
		self._title = title;
		super.init();
	}
	
	override convenience init()
	{
		self.init(location: CLLocationCoordinate2DMake(51.7611801, 5.514048199999934), title: "Oss");
	}
}
