//
//  JobServiceTest.swift
//  JobListTests
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import JobList

class NetworkMock: NetworkUseCase {
    func send(url: String, completion: @escaping (ResultType) -> Void) {
        guard let modelToTestData = Fixture.getData("jobs") else { return XCTAssert(true, "json file error") }
        completion(.success(modelToTestData))
    }
}

class JobServiceTest: XCTestCase {
    let network = NetworkMock()
    var jobservice: JobServiceUseCase?
    
    override func setUp() {
        jobservice = JobService(network)

    }


    func testJobService_WhenNetworkProduceSuccessfulData_ThenJobServiceShouldReturnAModel() {
        
        jobservice?.sendJobService(completion: { (resultData) in
            switch resultData {
            case .success(let appModel):
                XCTAssertEqual(appModel.data.items.count, 2)
                guard let jobLocation = appModel.data.items.last?.jobLocation else { return }
                XCTAssertEqual(jobLocation.addressStreet, "A Street Address")
            default:
                break
            }
        })
    }
}
