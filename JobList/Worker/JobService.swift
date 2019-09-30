//
//  JobService.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol JobServiceUseCase {
    typealias ResulType = Result<AppModelData, AppError>
    var network: NetworkUseCase { get set }
    func sendJobService(completion: @escaping(ResulType) -> Void)
}

// Final class for JobService to fetch data from network and create a AppModel
// Send it as a Result type if successful else send a Result type failure with error
final class JobService: JobServiceUseCase {
    var network: NetworkUseCase
    
    init(_ network: NetworkUseCase = Network()) {
        self.network = network
    }
    
    func sendJobService(completion: @escaping (ResulType) -> Void) {
        network.send(url: AppConstant.BaseUrl) { (networkResult) in
            var serviceResult: ResulType
            switch networkResult {
            case .success(let data):
                let modelDataResult: ResulType = Serialize.parse(data: data)
                switch modelDataResult {
                case .success(let appData):
                    serviceResult = .success(appData)
                case .failure(let error):
                    serviceResult = .failure(error)
                }
            case .failure(let error):
                serviceResult = .failure(error)
            }
            DispatchQueue.main.async {
                completion(serviceResult)
            }
        }
    }
}
