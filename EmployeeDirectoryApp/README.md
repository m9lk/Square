## Build tools & versions used

Built with XCode Version 14.1 & Objective-C

Targets iOS 12+

## Steps to run the app

1) Using Terminal navigate to project folder
2) Run pod install
3) Open EmployeeDirectoryApp.xcworkspace
4) For each Target -> Signing & Capabilities -> Team -> Select Team
5) run the project on your preferred device or simulator

## What areas of the app did you focus on?

I equally focused on all areas of the App:
- MVC architecture
- Built a Client on top of AFNetworking’s AFHTTPSessionManager
- Built my own custom Requests, Response and ResponseError Objects
- VC observes Data changes through Selector 
- Client’s public methods are mocked and Unit tested
- Models & data unwrapping are Unit tested
- App supports Dark mode
- Optimized for iPhone but runs well on iPad

## What was the reason for your focus? What problems were you trying to solve?

My architecture of choice for this project was MVC ; Simple, clean, enables fast development and straight forward when it comes to Unit Test.

## How long did you spend on this project?

Around 5h, a few hours everyday.

## What would you have done differently with more time?  

- Implement more Tests
- Programatically create Views instead of using Storyboards and Xibs 
- Implement caching solution instead of using SDWebImage
- Implement Reachability to observe/check connectivity 
- Add Headers to TableView sections
- Implement an index list (like the iOS native Contacts App) to enable fast scrolling

## What do you think is the weakest part of your project?

In a world of SwiftUI and Compose, Storyboards and Xibs are the weakest part of this project. 

## Did you copy any code or dependencies? Please make sure to attribute them here!

Code is my own, developed from scratch.

Leveraged the following Cocoapods : 
    'AFNetworking' : Used to build Client class
    'SDWebImage'  : Used for image caching 
