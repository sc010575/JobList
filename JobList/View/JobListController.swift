//
//  ViewController.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class JobListController: UITableViewController {

    var viewModel: JobListViewModelUseCase!
    var items = [JobCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Job List"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        fetchJobs()
    }
    
    fileprivate func fetchJobs() {
        viewModel.fetchJobs { (result) in
            switch result {
            case .success(let jobCellViewModels):
                self.items = jobCellViewModels
                self.tableView.reloadData()
            case .failure(let error):
                //Should show a alert view for the error (Not implemented)
                print(error.localizedDescription)
            }
        }
    }
}

extension JobListController
{
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JobListTableViewCell.self), for: indexPath) as! JobListTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
}
