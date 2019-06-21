//
//  SideMenu+UITableView.swift
//  iOS-Swift-Calendar
//
//  Created by IFang LEE on 2019/6/16.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

extension SideMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard
            let menuSections = viewModel?.menuSections,
            let option = menuSections[indexPath.section].options[safe: indexPath.row]
        else {
            
            return nil
        }
        
        if
            let showOption = (option as? MenuShowOption),
            case .holidays(let country) = showOption,
            let cell = tableView.cellForRow(at: indexPath) as? SideMenuOptionCell
        {
            cell.toggleCheckbox()
            
            delegate?.toggleHolidayOption(
                for: country,
                isSelected: cell.viewModel?.isSelected == true
            )
            
            return nil
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard
            let menuSections = viewModel?.menuSections,
            let option = menuSections[indexPath.section].options[safe: indexPath.row],
            let menuShowOption = option as? MenuCalendarTypeOption
        else {
            
            return
        }
    }
}

// MARK: - UITableViewDataSource

extension SideMenuView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel?.menuSections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard
            let menuSections = viewModel?.menuSections,
            let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: "SideMenuSectionHeaderView"
            ) as? SideMenuSectionHeaderView
        else {
            
            return nil
        }
        
        headerView.setup(title: menuSections[section].title)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return SideMenuView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.menuSections[section].options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let menuSections = viewModel?.menuSections,
            let option = menuSections[indexPath.section].options[safe: indexPath.row],
            let cell: SideMenuOptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        else {
            
            return UITableViewCell()
        }
        
        if
            isInit,
            (option as? MenuCalendarTypeOption) == .month
        {
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            
            isInit = false
        }
        
        cell.setup(viewModel:
            SideMenuOptionCellViewModel(option: option)
        )
        
        return cell
    }
}
