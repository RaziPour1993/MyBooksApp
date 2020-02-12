//
//  TableViewSectionViewModel.swift
//  Avicenna
//
//  Created by Mohammad Razipour on 10/1/19.
//  Copyright © 2019 ConicSoftwareSolutions. All rights reserved.
//

import Foundation


protocol TableViewSectionModel {
    var cellModels: [TableViewCellModel] {get set}
    var headerSectionModel: TableViewHeaderSection? {get set}
    var footerSectionModel: TableViewFooterSectionModel? {get set}
}

