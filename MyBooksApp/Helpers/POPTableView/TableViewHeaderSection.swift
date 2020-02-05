//
//  TableViewHeaderSectionModel.swift
//  Avicenna
//
//  Created by Mohammad Razipour on 10/1/19.
//  Copyright © 2019 ConicSoftwareSolutions. All rights reserved.
//

import Foundation

protocol TableViewHeaderSection {
    var identifier: String { get }
}

protocol ConfigurableTableViewHeaderSectionModel {
    func configure(with model: TableViewHeaderSection)
}
