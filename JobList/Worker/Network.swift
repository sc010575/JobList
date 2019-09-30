//
//  Network.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

enum AppConstant {
    static let BaseUrl = "https://www.coople.com/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200"
}

enum AppError: Error {
    case networkError(message: String)
    case dataError(message: String)
    case jsonError(message: String)
}

protocol NetworkUseCase {
    typealias ResultType = Result<Data, AppError>
    func send(url: String, completion: @escaping (ResultType) -> Void)
}


final class Network: NetworkUseCase {
    func send(url: String, completion: @escaping (ResultType) -> Void) {

        guard let baseUrl = URL(string: url) else { return completion(.failure(.dataError(message: "Url is not correct")))

        }

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: baseUrl) { (data, response, error) in
            var result: ResultType
            if let error = error {
                result = .failure(.networkError(message: error.localizedDescription))
            } else {

                if let httpResponse = response as? HTTPURLResponse, let data = data,
                    httpResponse.statusCode == 200 {
                    result = .success(data)
                } else {
                    result = .failure(.dataError(message: "Data/Server error"))
                }
            }
            DispatchQueue.main.async {
                completion(result)
            }

        }
        task.resume()
    }
}


