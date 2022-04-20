//
//  ViewController.swift
//  MySchedule
//
//  Created by Igor on 19.04.2022.
//

import FSCalendar
import UIKit

class ScheduleViewController: UIViewController {
    private var calendarHeightConstraint: NSLayoutConstraint!
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .week
        return calendar
    }()

    private lazy var expandCalendarButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Expand Calendar", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.titleLabel?.minimumScaleFactor = 0.5
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Schedule"
        
        calendar.dataSource = self
        calendar.delegate = self
        
        expandCalendarButton.addTarget(
            self,
            action: #selector(expandCalendarButtonPressed),
            for: .touchUpInside
        )
        
        setConstaints()
        swipeAction()
    }
    
    @objc func expandCalendarButtonPressed() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            expandCalendarButton.setTitle("Collapse Calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            expandCalendarButton.setTitle("Expand Calendar", for: .normal)
        }
    }
    
    // MARK: - SwipeGestureRecognizer
    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case.up where calendar.scope == .month: expandCalendarButtonPressed()
        case.down where calendar.scope == .week: expandCalendarButtonPressed()
        default: break
        }
    }
}

// MARK: - FSCalendarDelegate and FSCalendarDataSource

extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(
        _ calendar: FSCalendar,
        boundingRectWillChange bounds: CGRect,
        animated: Bool
    ) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}

// MARK: - SetConstraints

extension ScheduleViewController {
    func setConstaints() {
        let safeArea = view.safeAreaLayoutGuide
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(
            item: calendar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 300
        )
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        expandCalendarButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(expandCalendarButton)
        NSLayoutConstraint.activate([
            expandCalendarButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            expandCalendarButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            expandCalendarButton.widthAnchor.constraint(equalToConstant: 100),
            expandCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
