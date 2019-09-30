//
//  JobListViewModelTest.swift
//  JobListTests
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import JobList

class JobListViewModelTest: XCTestCase {

    let network = NetworkMock()
    var jobservice: JobServiceUseCase?
    var viewModel:JobListViewModelUseCase?
    
    override func setUp() {
        jobservice = JobService(network)
        self.viewModel = JobListViewModel(jobservice!)
    }

    func test_WhenViewModelHaveAValidService_ThenViewModelShouldHaveRightData() {
        
        let extectation = expectation(description: "fatch jobs")
        viewModel?.fetchJobs(completion: { (resultSuccess) in
            extectation.fulfill()
            switch resultSuccess {
            case .success(let testCellViewModels):
                XCTAssertEqual(testCellViewModels.count, 2)
                let testCellViewModel = testCellViewModels[0]
                XCTAssertEqual("Doughnut Seller at a stadium",testCellViewModel.assigenment)
                XCTAssertEqual(testCellViewModel.zipCity, "Zip:Wembley  City:HA9")
            default:
                break
            }
        })
        self.waitForExpectations(timeout: 1, handler: nil)
    }
}
