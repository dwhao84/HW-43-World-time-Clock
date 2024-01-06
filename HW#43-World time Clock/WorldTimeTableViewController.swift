//
//  WorldTimeTableViewController.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class WorldTimeTableViewController: UIViewController {

    var rightBarButton: UIBarButtonItem = UIBarButtonItem()
    var leftBarButton:  UIBarButtonItem = UIBarButtonItem()
   
    var tableView: UITableView   = UITableView ()
    
    static var tableViewArray: [Int] = [1]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SystemColor.black
        
        setupTableView                ()
        addDelegateAndDataSource      ()
        configureBarButton            ()
        configureNavigationController ()
        configureTableView            ()
    }
    
    func setupTableView () {
        tableView.rowHeight       = 105
        tableView.backgroundColor = SystemColor.black
        tableView.separatorColor  = SystemColor.darkGray
        tableView.separatorStyle  = .singleLine
        tableView.register(WorldTimeTableViewCell.nib(), forCellReuseIdentifier: WorldTimeTableViewCell.identifer)
    }
    
    func addDelegateAndDataSource () {
        tableView.delegate   = self
        tableView.dataSource = self
    }

    func configureTableView () {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureBarButton () {
        rightBarButton = UIBarButtonItem(
            image:  BarButtonItem.plusImage,
            style: .plain,
            target: self,
            action: #selector(showCountryTableVC))
        leftBarButton = UIBarButtonItem(
            title: "Edit",
            style: .done,
            target: self,
            action: nil)
        
        self.navigationItem.leftBarButtonItem              = leftBarButton
        self.navigationItem.rightBarButtonItem             = rightBarButton
        self.navigationController?.navigationBar.tintColor = SystemColor.orange
    }
    
    func configureNavigationController () {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationItem.title = "World Clocks"
    }
    
    @objc func showCountryTableVC () {
        let countryTableVC: UIViewController = CountryTableViewController()
        present(countryTableVC, animated: true)
    }
}

extension WorldTimeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
                WorldTimeTableViewController.tableViewArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                completionHandler(true)
            }
        return UISwipeActionsConfiguration(actions: [deleteRow])
    }
    
}

extension WorldTimeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorldTimeTableViewController.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldTimeTableViewCell.identifer, for: indexPath) as? WorldTimeTableViewCell else {
            fatalError("Unable to dequeueReusableCell")
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: WorldTimeTableViewController())
}
