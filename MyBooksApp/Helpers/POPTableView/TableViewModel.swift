//
//  TableViewModel.swift
//  Avicenna
//
//  Created by Mohammad Razipour on 10/1/19.
//  Copyright © 2019 ConicSoftwareSolutions. All rights reserved.
//

import Foundation
import UIKit


protocol TableViewModel {
    var sections:[TableViewSectionModel]! { get }
}

extension TableViewModel {
    
    var isEmpty: Bool {
        var count = 0
        
        self.sections.forEach { (item) in
            if !item.cellModels.isEmpty || item.footerSectionModel != nil || item.headerSectionModel != nil {
                count += 1
            }
        }
        
        return count <= 0
        
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].cellModels.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> TableViewCellModel {
        return sections[indexPath.section].cellModels[indexPath.row]
    }
    
    func header(at section: Int)-> TableViewHeaderSection? {
        return sections[section].headerSectionModel
    }
    
    func footer(at section: Int)-> TableViewFooterSectionModel? {
        return sections[section].footerSectionModel
    }
    
}
