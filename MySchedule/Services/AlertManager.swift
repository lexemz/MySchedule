//
//  AlertManager.swift
//  MySchedule
//
//  Created by Igor on 26.04.2022.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    private let calendar = Calendar.current
    
    private init() {}
    
    /// Displays AlertController for date selection
    ///
    /// Completion parameters:
    /// - weekday: Int - returns the day of the week (Sun - 1, Mon - 2, etc.)
    /// - systemTime: NSDate
    /// - stringTime: String - parameter for displaying data in the UI
    func showAlertWithDatePicker(
        onScreen viewController: UIViewController,
        completion: @escaping (
            _ weekday: Int,
            _ systemDate: NSDate,
            _ stringDate: String
        ) -> Void
    ) {
        let alertController = UIAlertController(
            title: "",
            message: nil,
            preferredStyle: .actionSheet
        )
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            let stringDate = dateFormatter.string(from: datePicker.date)
            
            let component = self.calendar.dateComponents([.weekday], from: datePicker.date)
            guard let weekdayInt = component.weekday else { return }
            let systemDate = datePicker.date as NSDate
            
            completion(weekdayInt, systemDate, stringDate)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.view.addSubview(datePicker)
        alertController.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalTo: alertController.view.widthAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 285),
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor)
        ])
        
        viewController.present(alertController, animated: true)
    }
    
    /// Displays AlertController for time selection
    ///
    /// Completion parameters:
    /// - systemTime: NSDate
    /// - stringTime: String - parameter for displaying data in the UI
    func showAlertWithTimePicker(
        onScreen viewController: UIViewController,
        completion: @escaping (
            _ systemTime: NSDate,
            _ stringTime: String
        ) -> Void
    ) {
        let alertController = UIAlertController(
            title: "",
            message: nil,
            preferredStyle: .actionSheet
        )
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "en_GB")
        
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            let stringTime = dateFormatter.string(from: timePicker.date)
            let systemTime = timePicker.date as NSDate
            
            completion(systemTime, stringTime)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.view.addSubview(timePicker)
        alertController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePicker.widthAnchor.constraint(equalTo: alertController.view.widthAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 185),
            timePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor)
        ])
        
        viewController.present(alertController, animated: true)
    }
    
    /// Displays an AlertController with a single textfield
    ///
    /// Completion parameters:
    /// - text: String - returns data from a text field
    func showAlertWithTextField(
        onScreen viewController: UIViewController,
        title: String,
        completion: @escaping (_ text: String) -> Void
    ) {
        let alertContoller = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let tfAlert = alertContoller.textFields?.first
            guard let text = tfAlert?.text else { return }
            completion(text)
        }
        
        alertContoller.addTextField { textField in
            textField.placeholder = "Type Anytihng"
        }
        
        alertContoller.addAction(cancelAction)
        alertContoller.addAction(okAction)
        
        viewController.present(alertContoller, animated: true)
    }
}
