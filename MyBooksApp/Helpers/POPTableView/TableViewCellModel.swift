//
//  TableViewCellModel.swift
//  Avicenna
//
//  Created by Mohammad Razipour on 10/1/19.
//  Copyright © 2019 ConicSoftwareSolutions. All rights reserved.
//

import Foundation

protocol TableViewCellModel {
    func identifier()-> String
}

protocol ConfigurableTableViewCell {
    func configure(with model: TableViewCellModel, indexPath: IndexPath)
}
