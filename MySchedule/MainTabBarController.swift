//
//  MainTabBarController.swift
//  MySchedule
//
//  Created by Igor on 19.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let scheduleVC = makeNavigationController(
            viewController: ScheduleViewController(),
            itemName: "Schedule",
            itemImage: "calendar"
        )
        let tasksVC = makeNavigationController(
            viewController: TasksViewController(),
            itemName: "Tasks",
            itemImage: "doc.text.fill"
        )
        let contactsVC = makeNavigationController(
            viewController: ContactsViewController(),
            itemName: "Contacts",
            itemImage: "person.3.fill"
        )
        
        viewControllers = [scheduleVC, tasksVC, contactsVC]
    }
    
    func makeNavigationController(
        viewController: UIViewController,
        itemName: String,
        itemImage: String
    ) -> UINavigationController {
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage),
            tag: 0
        )
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        return navController
    }
}
