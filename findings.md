# Personal findings and notes
This file contains a list of findings and notes from my walkthrough of the iOS Programming book of Big Nerd Ranch. Again, this is just for playing and experimenting. Some of the iOS basics are already covered by the other repository, this book will deepen the building for iOS.

## Setting up / First iOS
- The first steps regarding the setup of a iOS project is covered in chapter 1 of the book, however, this overlaps with the other book, so this chapter is skipped.
- The third edition of the book is using XCode 4.3, so some things might have changed in newer versions, my development is done on XCode 9.
- The MVC pattern in the book is "explained" as: 
    - Model -> the objects that are used and mutated by the application
    - Controller -> The controller class created in the projects (responsible for coordination between the other layers)
    - View -> The separate elements on the screen (no real view class, but a collection of elements being the view)
- Chapter 2 of the book covers the basics of Objective-C, so we'll skip that one 🤠
- Chapter 3 is memory management and ARC (ref count), this is covered in the book for Objective-C and therefor skipped by me. However memory and references are covered in the other book about Swift.

## Objective-C -> Swift
Notes regarding reading Obective-C code and transforming/interpreting it to Swift.
- Properties in Objective-C often (for example on the MKMapView) use an explicit set/get (e.g. setShowsUserLocation(true)), where Swift exposes them as "real" properties (showsUserLocation = true);

## Chapter 4: Delegation and core location & Chapter 5: MapView
- Adding frameworks is done in Project settings -> Build Phases -> Link binary with libraries -> + (to add a reference, in this case to CoreLocation).
- In the book they describe a solution to override the init to set some elements
```swift
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
	{
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
	}
```
This however yields an error stating that an additional override is required.
```swift	
	required init?(coder aDecoder: NSCoder!)
	{
		super.init(coder: aDecoder)
	}
```
After implementing the other init function, compile succeeds(https://stackoverflow.com/questions/25267907/initwithnibname-does-not-implement-superclass-swift)
- However the inint with the nibNameOrNil does not seem to be called when running the application. Some poking around showed that the init?(:NSCoder) is called, so we put the code there for now.
- To log debug messages you can also use NSLog() instead of print()
- You can use the circle with the arrow in the right menu (where the properties are) on the scene to see all outlets.
- Working with locations has changed quite a bit since the book was released. You now need to request permission on your location manager instance ```locationManager.requestWhenInUseAuthorization();```. This seems to allow the app to use location wherever (so not only on the location manager, but also on map views). When requesting authorization, iOS will require you te set a info.plist value indicating WHY you want access by adding a key ```NSLocationAlwaysUsageDescription``` with the description (will be translated to the privacy key "Privacy - Location When In Use Usage Description" XCode). This text will be shown to the user. The debugger will warn you if the key is missing in the debug messages and will NOT grant GPS access nor will it show the request to the user.
- A lot of helper functions are globally scoped like: ```MKCoordinateRegionMakeWithDistance()``` and ```CLLocationCoordinate2DMake``` which are available in the MapKit framework. I would have expected these to be statics in the classes, but they are put in the namespace.
- Some UI elements do not support delegates, but work with targets and actions (I need to further investigate that)
- You can always use the IBActions to link action elements to backend functions
- In the example I found that the delegate for the TextField needs to be set in the viewdidload and not in the init. Assigning it in the init fails to yield the correct result (textbox stays active and the return event is not triggered). Don't know why...

## Chapter 6: Subclassing view and scrollview
- Empty application template is no longer available in XCode 9, to make an empty project make a default project and follow these steps: https://github.com/simonyang81/Knowledge/wiki/How-to-create-an-empty-application-with-Xcode-6,-7-&-8
- CGRectMake is not available in Swift, replaced with: ```CGRect(x: 160, y: 240, width: 100, height: 150);```
- You have to create the window with it's bounds. In the old examples these are already created in the generated code, but in newer versions they are not. So make sure to create self.window in the appdelegate, otherwise it's nil and calls like window?.addSubview() will not be executed due to the window being nil.
```swift
	//Setup the window
	self.window = UIWindow(frame: UIScreen.main.bounds);
	self.window?.rootViewController = ViewController();

	//Setup the view
	let frame = CGRect(x: 25, y: 25, width: 100, height: 150);
	let hv = HypnoView(frame: frame);
	hv.backgroundColor = UIColor.red;
	window?.addSubview(hv);
		
	//Focus the window
	window?.makeKeyAndVisible();
```

### Regarding controls and elements
- Textfield: If you want to catch the event of the user pressing done/return on the keyboard in a text field you can use the UITextFieldDelegate.


### TODO
- Investigate the working of targets (like the UISegmentedControl uses)