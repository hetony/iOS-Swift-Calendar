//
//  CalendarCell.swift
//  Alamofire
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.//

import JTAppleCalendar

protocol CalendarCellDelegate: class {
    
    func didSelect(holiday: Holiday)
}

final class CalendarCell: JTAppleCell, NibLoadableView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var highlightView: UIView!
    @IBOutlet private weak var eventTableView: UITableView!
    
    // MARK: - Constants
    
    private static let highlightViewCornerRadius: CGFloat = 15
    private static let maxShowingHolidays: CGFloat = 3
    
    // MARK: - Variable
    
    var holidays = [Holiday]()
    var delegate: CalendarCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        highlightView.backgroundColor = .white
    }
}

// MARK: - Helper Functions

extension CalendarCell {
    
    private func setupUI() {
        
        highlightView.layer.cornerRadius = CalendarCell.highlightViewCornerRadius
        highlightView.layer.masksToBounds = true
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(HolidayCell.self)
        eventTableView.separatorStyle = .none
    }
    
    func setup(with cellState: CellState, holidays: [Holiday], calendar: Calendar = Calendar.current) {
        
        dayLabel.text = cellState.text
        self.holidays = holidays
        eventTableView.reloadData()
        
        guard cellState.isSelected else {
            
            highlightView.backgroundColor = Colors.General.background
            
            dayLabel.textColor = cellState.dateBelongsTo == .thisMonth ?
                .black :
                Colors.General.lightText
            
            return
        }
        
        highlightView.backgroundColor = cellState.dateBelongsTo == .thisMonth ?
            Colors.General.active :
            Colors.General.background
        
        dayLabel.textColor = .white
    }
}

// NARK: UITableViewDelegate

extension CalendarCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / CalendarCell.maxShowingHolidays
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let holiday = holidays[safe: indexPath.row] else {
            
            return
        }
        
        delegate?.didSelect(holiday: holiday)
    }
}

// NARK: UITableViewDelegate

extension CalendarCell: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return min(holidays.count, Int(CalendarCell.maxShowingHolidays))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell: HolidayCell = tableView.dequeueReusableCell(forIndexPath: indexPath),
            let holiday = holidays[safe: indexPath.row]
        else {
            
            return UITableViewCell()
        }
        
        cell.setup(with: holiday)
        
        return cell
    }
}
