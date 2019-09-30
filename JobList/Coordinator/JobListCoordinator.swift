//
//  JobListCoordinator.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class JobListCoordinator: Coordinator {

    private let presenter: UINavigationController
    init(_ presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: JobListController.self)) as? JobListController else { return }

        let viewModel = JobListViewModel()
        vc.viewModel = viewModel
        presenter.pushViewController(vc, animated: true)
    }
}

