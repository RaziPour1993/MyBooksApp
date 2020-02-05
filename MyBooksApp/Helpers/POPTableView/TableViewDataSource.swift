//
//  TableViewDataSource.swift
//  Avicenna
//
//  Created by Mohammad Razipour on 10/1/19.
//  Copyright © 2019 ConicSoftwareSolutions. All rights reserved.
//

import Foundation
import UIKit

class TableViewModelTest: TableViewModel {
    
    var sections: [TableViewSectionModel]!
    
    init() {
        sections = []
    }
    
}

protocol TableViewDataSourceDelegate: class {
    func didSelect(rowAt indexPath: IndexPath, cellModel: TableViewCellModel)
}

class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: TableViewModel
    weak var delegate: TableViewDataSourceDelegate?
    
    init(model: TableViewModel = TableViewModelTest(), delegate: TableViewDataSourceDelegate? = nil) {
        self.delegate = delegate
        self.viewModel = model
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.cellForRow(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: model.identifier(), for: indexPath)
        guard let configurableCell = cell as? ConfigurableTableViewCell else { fatalError("Cell is not configurable \(String(describing: model.identifier))") }
        configurableCell.configure(with: model, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = self.viewModel.header(at: section) else { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: model.identifier) else { return nil }
        guard let configurableHeader = header as? ConfigurableTableViewHeaderSectionModel else { fatalError("Header is not configurable \(model.identifier)") }
        configurableHeader.configure(with: model)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = self.viewModel.footer(at: section) else { return nil }
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: model.identifier)
        guard let configurablefooter = footer as? ConfigurableTableViewFooterSectionModel else { fatalError("Footer is not configurable \(model.identifier)") }
        configurablefooter.configure(with: model)
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.didSelect(rowAt: indexPath, cellModel: viewModel.cellForRow(at: indexPath))
    }
    
}


