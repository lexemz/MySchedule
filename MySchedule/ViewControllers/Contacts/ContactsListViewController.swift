//
//  ContactsViewController.swift
//  MySchedule
//
//  Created by Igor on 19.04.2022.
//

import UIKit

class ContactsListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    private func setupScreen() {
        view.backgroundColor = .systemBackground
        title = "Contacts"
        
        tableView.register(
            ContactsTableViewCell.self,
            forCellReuseIdentifier: ContactsTableViewCell.id
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc private func addButtonTapped() {
        let form = ContactsFormTableViewController(style: .insetGrouped)
        let nc = UINavigationController(rootViewController: form)
        present(nc, animated: true)
    }
}

extension ContactsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ContactsTableViewCell.id
        ) as! ContactsTableViewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
