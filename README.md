# JobList
Presenting a list of “jobs" in the following way

![image_preview](https://user-images.githubusercontent.com/1453658/65918624-ff281e00-e3d1-11e9-978f-cd5b33fd9897.png)

### Api Links
- https://www.coople.com/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200

### Development Platform
- iOS 12.2 and XCode 10.2.1
- Swift 5

### Targets
- JobList - Main application target
- JobListTests - Unit testing target

### Instruction to run
- Download/ Clone the project from URL or .Zip
- open JobList.xcodeproj and run in the simulator

### Swift architecture
- The application is build with MVVM-C (Model-View-ViewModel and Coordinator) architecture. Use of coordinator patern for navigation. Therefore viewcontrollers are free from navigation. 
- Universal App that support different layouts for iPhone and iPad in horizental and vertical orientation.

### Code Coverage
- Current code coverage is 85%

### Features
- After launching the application it will make an api call to retrive Jobs detail
- presenting a list of “jobs" 
