//
//  JobListTests.swift
//  JobListTests
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import JobList

class JobModelTests: XCTestCase {

    func test_GivenAModelResponse_WhenResponseHaveRightData_ThenAModelWillbeCreated() {

        guard let modelToTestData = Fixture.getData("jobs") else { return XCTAssert(true, "json file error") }

        let modelResult: Result<AppModelData?, AppError> = Serialize.parse(data: modelToTestData)

        switch modelResult {
        case .success(let modelToTest):
        XCTAssertEqual(modelToTest?.data.items.count, 2)
            XCTAssertEqual(modelToTest?.data.items.first?.workAssignmentName, "Doughnut Seller at a stadium")
        default:
            break
        }
    }
}
