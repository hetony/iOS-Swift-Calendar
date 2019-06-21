//
//  HolidayDetailViewController.swift
//  iOS-Swift-Calendar
//
//  Created by IFang Lee on 2019/6/19.
//  Copyright © 2019 IFang Lee. All rights reserved.
//

import UIKit
import UserNotifications

final class HolidayDetailViewController: UIViewController, ViewModelStoryboardInit {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet weak private var itemTableView: UITableView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak private var changeNotificationButton: UIButton!
    
    private lazy var pickerView = createPickerView()
    private lazy var notificationTimePickerToolBar = createNotificationTimePickerToolBar()
    
    var pickerViewOptions: [NotificationTimeOption] = [
        .none, .oneDay, .oneHour, .thirtyMins, .tenMins
    ]
    
    var viewModel: HolidayDetailViewModel?
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        viewModel?.getNotificationTimeOption()

        setupUI()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: Setup UI

private extension HolidayDetailViewController {
    
    func setupUI() {
        
        title = viewModel?.holiday.name
        
        itemTableView.rowHeight = 50
        itemTableView.dataSource = self
        itemTableView.separatorStyle = .none
        itemTableView.isUserInteractionEnabled = false
        itemTableView.register(HolidayDetailCell.self)
        
        textField.inputView = pickerView
        textField.inputAccessoryView = notificationTimePickerToolBar

        changeNotificationButton.addTarget(
            self,
            action: #selector(touchUpInsideChangeNotificationButton),
            for: .touchUpInside
        )
        
        let notificationTimeOption = viewModel?.notificationTimeOption ?? .none
        notificationLabel.text = notificationTimeOption.title
    }
    
    func createNotificationTimePickerToolBar() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(confirmPickerSelection)
        )
        
        doneButton.accessibilityIdentifier = "toolbar_done_button"
        
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelPickerSelection)
        )
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    func createPickerView() -> UIPickerView {
        
        let pickerView = UIPickerView()
        
        pickerView.backgroundColor = .white
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
    }
    
    @objc func confirmPickerSelection() {
        
        let optionIndex = pickerView.selectedRow(inComponent: 0)

        viewModel?.notificationTimeOption = (pickerViewOptions[safe: optionIndex] ?? .none)
        
        textField.resignFirstResponder()
        
        // Create Notification
        
        showLoadingIndicator()
        
        viewModel?.createNotification { [weak self] error in
            
            DispatchQueue.main.async {
                
                self?.hideLoadingIndicator()
                
                guard
                    let error = error,
                    (error as? NotificationError) != .setNoNotification
                else {
                    
                    return
                }
                
                print(error.localizedDescription)
                
                self?.showAlert(
                    title: "Error",
                    message: "Something went wrong when setting notification, please try it again."
                )
            }
        }
    }
    
    @objc func cancelPickerSelection() {
        
        textField.resignFirstResponder()
    }
}

// MARK: Actions

private extension HolidayDetailViewController {
    
    @objc func touchUpInsideChangeNotificationButton(_ sender: UIButton) {
        
        UNUserNotificationCenter
            .current()
            .getNotificationSettings { [weak self] (settings) in
                
                switch settings.authorizationStatus {
                case .authorized:
                    
                    DispatchQueue.main.async {
                        
                        self?.pickerView.isHidden = false
                    }
                default:
                    
                    let alert = UIAlertController(
                        title: "Error",
                        message: "Please go to Settings to turn on notification.",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(
                        UIAlertAction(title: "Cancel", style: .cancel
                        )
                    )
                    
                    alert.addAction(
                        UIAlertAction(title: "Settings", style: .default) { [weak self] _ in
                            
                            self?.openSystemSettings()
                        }
                    )
                    
                    self?.present(alert, animated: true)
                }
        }
    }
}
