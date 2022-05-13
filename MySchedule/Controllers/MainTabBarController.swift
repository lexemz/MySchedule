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
            viewController: ScheduleListViewController(),
            itemName: "Schedule",
            itemImage: "calendar",
            selectedItemImage: "calendar"
        )
        let tasksVC = makeNavigationController(
            viewController: TasksListViewController(),
            itemName: "Tasks",
            itemImage: "doc.text",
            selectedItemImage: "doc.text.fill"
        )
        let contactsVC = makeNavigationController(
            viewController: ContactsListViewController(),
            itemName: "Contacts",
            itemImage: "person.3",
            selectedItemImage: "person.3.fill"
        )
        
        viewControllers = [scheduleVC, tasksVC, contactsVC]
    }
    
    func makeNavigationController(
        viewController: UIViewController,
        itemName: String,
        itemImage: String,
        selectedItemImage: String
    ) -> UINavigationController {
        let item = UITabBarItem(
            title: itemName,
            image: UIImage(systemName: itemImage),
            selectedImage: UIImage(systemName: selectedItemImage)
        )
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        return navController
    }
}
