//
//  AppModel.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

//App Model based on the json structure
struct AppModelData: Decodable {
    let data:ItemDetails
}
struct ItemDetails:Decodable {
    let items: [WorkDetails]
}
struct WorkDetails:Decodable {
    let workAssignmentName:String?
    let jobLocation: JobLocation
}

struct JobLocation: Decodable{
    let addressStreet: String?
    let zip: String?
    let city: String?
}
