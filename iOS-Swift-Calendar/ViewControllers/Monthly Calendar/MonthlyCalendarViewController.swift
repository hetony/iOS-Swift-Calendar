//
//  MonthlyCalendarViewController.swift
//  Calendar
//
//  Created by IFang Lee on 2019/6/13.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol MonthlyCalendarDelegate: class {
    
    func didChangeMonth(to date: Date)
}

class MonthlyCalendarViewController: UIViewController, ViewModelStoryboardInit {
    
    // MARK: - Outlets
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var sideMenuView: SideMenuView!
    
    // MARK: - Variables
    
    var viewModel: MonthlyCalendarViewModel?
    weak var delegate: MonthlyCalendarDelegate?

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: Setup UI

private extension MonthlyCalendarViewController {
    
    func setupUI() {
        
        // Calendar View
        
        setupCalendarView()
        
        // Side Menu View
        
        sideMenuView.delegate = self
        setupSideMenuView()
        
        // Navigation View
        
        navigationView.delegate = self
        setupNavigationBackButton()
    }
    
    func setupCalendarView() {
        
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.register(CalendarCell.self)
        calendarView.scrollingMode = .stopAtEachSection
        calendarView.minimumInteritemSpacing = 4
        calendarView.minimumLineSpacing = 4
        
        let selectedDate = Date()
        calendarView.selectDates([selectedDate])
        calendarView.reloadData()
        calendarView.scrollToDate(selectedDate)
        
        delegate?.didChangeMonth(to: selectedDate)
    }
    
    func setupSideMenuView() {
        
        sideMenuView.hide()
        sideMenuView.viewModel = SideMenuViewModel()
        
        view.isUserInteractionEnabled = true
        view.addSubview(sideMenuView)
        view.bringSubviewToFront(sideMenuView)
    }
    
    func setupNavigationBackButton() {
        
        let backButtonImage = UIImage(named: "navigation_back_button_icon")
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}

// MARK: Helper Functions

extension MonthlyCalendarViewController {
    
    func fetchHolidays(for country: Country) {
        
        viewModel?.fetchHolidays(for: country) { [weak self] result in
            
            if case .failure(let error) = result {
                
                self?.showAlert(title: "Error", message: error.localizedDescription)
                
                return
            }
            
            self?.calendarView.reloadData()
        }
    }
}

// MARK: CalendarCellDelegate

extension MonthlyCalendarViewController: CalendarCellDelegate {
   
    func didSelect(holiday: Holiday) {
        
        let holidayDetailViewModel = HolidayDetailViewModel(holiday: holiday)
        
        let holidayDetailViewController = HolidayDetailViewController.storyboardInit(
            viewModel: holidayDetailViewModel
        )
        
        navigationController?.pushViewController(holidayDetailViewController, animated: true)
    }
}
