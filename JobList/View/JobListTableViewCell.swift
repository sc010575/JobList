//
//  JobListTableViewCell.swift
//  JobList
//
//  Created by Suman Chatterjee on 30/09/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class JobListTableViewCell: UITableViewCell {

    @IBOutlet weak var workAssignmentLabel: UILabel!
    @IBOutlet weak var jobAddressLabel: UILabel!
    @IBOutlet weak var zipCodeCityLabel: UILabel!

    var item: JobCellViewModel? {
        didSet {
            workAssignmentLabel.text = item?.assigenment
            jobAddressLabel.text = item?.address
            zipCodeCityLabel.text = item?.zipCity
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupCell()
    }

    fileprivate func setupCell() {
        workAssignmentLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        jobAddressLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        zipCodeCityLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        workAssignmentLabel.textColor = UIColor(red: 0.99, green: 0.5, blue: 0, alpha: 1.0) //Orange Color
        jobAddressLabel.textColor = .gray
        zipCodeCityLabel.textColor = .lightGray
    }
}
