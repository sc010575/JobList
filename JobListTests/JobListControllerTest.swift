//
//  JobListControllerTest.swift
//  JobListTests
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import JobList

extension UIViewController {
    func preloadView() {
        _ = view
    }
    
    @discardableResult
    func appearInWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.makeKeyAndVisible()
        
        _ = self.view
        return window
    }
    
}

class JobListViewModelMock: JobListViewModelUseCase {
    var jobService: JobServiceUseCase
    
    init(_ jobService:JobServiceUseCase = JobService()) {
        self.jobService = jobService
    }

    func fetchJobs(completion: @escaping (ResultType) -> Void) {
        let mockWorkdetails = [WorkDetails(workAssignmentName: "A AssignMent", jobLocation: JobLocation(addressStreet: "A Address", zip: "A Zip", city: "A City")),
        WorkDetails(workAssignmentName: "A New AssignMent", jobLocation: JobLocation(addressStreet: "A new Address", zip: "A new Zip", city: "A new City"))
                               ]
        let jobCellViewModels = mockWorkdetails.map { JobCellViewModel($0) }
        completion(.success(jobCellViewModels))
    }
    
    
}

class JobListControllerTest: XCTestCase {

    let network = NetworkMock()
    var jobservice: JobServiceUseCase?
    var viewModel:JobListViewModelUseCase?
    var viewControllerOnTest: JobListController?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    override func setUp() {
        viewControllerOnTest = storyboard.instantiateViewController(withIdentifier: "JobListController") as? JobListController
        jobservice = JobService(network)
        self.viewModel = JobListViewModelMock(jobservice!)
    }


    func testJobListController_WhenLoaded() {
        viewControllerOnTest?.viewModel = self.viewModel
        viewControllerOnTest?.appearInWindow()
        XCTAssertEqual(viewControllerOnTest?.title, "Job List")
    }

    func test_GivenJobListControllerLoaded_WhenViewModelFetchData_ThenShouldHaveAListOfCellViewModels (){
        viewControllerOnTest?.viewModel = self.viewModel
        viewControllerOnTest?.appearInWindow()
        viewControllerOnTest?.viewDidLoad()
        XCTAssertEqual(viewControllerOnTest?.items.count, 2)
        
        let cell = viewControllerOnTest?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? JobListTableViewCell
        guard let assignment = cell?.workAssignmentLabel.text,
            let address = cell?.jobAddressLabel.text,
            let zipCity = cell?.zipCodeCityLabel.text else {
            return XCTAssert(true)
        }
        XCTAssertEqual(assignment, "A AssignMent")
        XCTAssertEqual(address, "A Address")
        XCTAssertEqual(zipCity, "Zip:A City  City:A Zip")

    }


}
