//
//  Serialization.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

// Protocol for Serialization
protocol serializable {
    typealias ResultType = Result<Model,AppError>
    associatedtype Model
    static func parse(data:Data) ->ResultType
}

// Generic class for Serialize - Can be able to parse any model
final class Serialize<T:Decodable> : serializable {
    typealias Model = T
    
    static func parse(data: Data) -> Result<T, AppError> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let resultModel = try decoder.decode(Model.self, from: data)
            return .success(resultModel)
            
        }catch  {
            return .failure(.jsonError(message: "Json parsing error"))
        }
    }
}
