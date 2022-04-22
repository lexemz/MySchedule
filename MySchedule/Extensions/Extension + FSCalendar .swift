//
//  Extension + FSCalendar .swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import FSCalendar

extension FSCalendar {
    func customCalendarAppearance() {
        appearance.weekdayTextColor = .systemBlue
        appearance.headerTitleColor = .systemBlue
        appearance.titleDefaultColor = .label
        appearance.titlePlaceholderColor = .systemGray2
        appearance.selectionColor = .systemBlue
    }
}
