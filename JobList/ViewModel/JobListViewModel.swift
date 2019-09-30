//
//  JobListViewModel.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

struct JobCellViewModel {
    var assigenment:String
    var address: String
    var zipCity: String
    
    init(_ workDetails:WorkDetails) {
        self.assigenment = workDetails.workAssignmentName ?? "Unknown Assignmet"
        self.address = workDetails.jobLocation.addressStreet ?? "Unknown Address"
        self.zipCity = "Zip:\(workDetails.jobLocation.city ?? "Unknown City")  City:\( workDetails.jobLocation.zip ?? "Unknown zip")"
        let address = self.address.count == 0 ? "Unknown Address" : self.address
        self.address = address
    }
}

protocol JobListViewModelUseCase {
    typealias ResultType = Result<[JobCellViewModel],AppError>
    var jobService:JobServiceUseCase {get set }
    func fetchJobs(completion: @escaping(ResultType) -> Void)
}

final class JobListViewModel: JobListViewModelUseCase {
    
    var jobService: JobServiceUseCase
    
    init(_ jobService:JobServiceUseCase = JobService()) {
        self.jobService = jobService
    }

    func fetchJobs(completion: @escaping(ResultType) -> Void) {
        jobService.sendJobService { (results) in
            switch results {
            case .success(let appModel):
                    let items = appModel.data.items
                    let cellViewModels = items.map{ JobCellViewModel($0)}
                    completion(.success(cellViewModels))
                
            case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
