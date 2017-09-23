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

## Chapter 4: Delegation and core location
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
- Properties in the book (for example on the MKMapView) use an explicit set (e.g. setShowsUserLocation(true)), where Swift used them as "real" properties (showsUserLocation = true);
- Working with locations has changed quite a bit since the book was released. You now need to request permission on your location manager instance ```locationManager.requestWhenInUseAuthorization();```. This seems to allow the app to use location wherever (so not only on the location manager, but also on map views). When requesting authorization, iOS will require you te set a info.plist value indicating WHY you want access by adding a key ```NSLocationAlwaysUsageDescription``` with the description (will be translated to the privacy key "Privacy - Location When In Use Usage Description" XCode). This text will be shown to the user. The debugger will warn you if the key is missing in the debug messages and will NOT grant GPS access nor will it show the request to the user.