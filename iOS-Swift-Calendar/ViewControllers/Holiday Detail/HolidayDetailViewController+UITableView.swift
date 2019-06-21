//
//  HolidayDetailViewController+UITableView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/20.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

extension HolidayDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell: HolidayDetailCell = tableView.dequeueReusableCell(forIndexPath: indexPath),
            let item = viewModel?.items[safe: indexPath.row]
        else {
            
            return UITableViewCell()
        }
        
        cell.setup(with: item)
        
        return cell
    }
}
