//
//  ApplicationCoordinator.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    enum CoordinatorKeys: String {
        case jobList
    }
    
    private let window: UIWindow
    private let navigationcontroller: UINavigationController
    private var coordinators = [String: Coordinator]()
    
    init(_ window: UIWindow) {
        self.window = window
        navigationcontroller = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationcontroller
        startJobList()
        window.makeKeyAndVisible()
    }
    
    fileprivate func startJobList() {
        let startJobsCoordinator = JobListCoordinator(navigationcontroller)
        coordinators[CoordinatorKeys.jobList.rawValue] = startJobsCoordinator
        startJobsCoordinator.start()
    }
}

