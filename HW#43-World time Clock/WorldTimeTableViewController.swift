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
   
    static var tableView: UITableView   = UITableView ()

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
        WorldTimeTableViewController.tableView.rowHeight       = 105
        WorldTimeTableViewController.tableView.backgroundColor = SystemColor.black
        WorldTimeTableViewController.tableView.separatorColor  = SystemColor.darkGray
        WorldTimeTableViewController.tableView.separatorStyle  = .singleLine
        WorldTimeTableViewController.tableView.register(WorldTimeTableViewCell.nib(), forCellReuseIdentifier: WorldTimeTableViewCell.identifer)
    }
    
    func addDelegateAndDataSource () {
        WorldTimeTableViewController.tableView.delegate   = self
        WorldTimeTableViewController.tableView.dataSource = self
    }

    func configureTableView () {
        view.addSubview(WorldTimeTableViewController.tableView)
        WorldTimeTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            WorldTimeTableViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            WorldTimeTableViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            WorldTimeTableViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            WorldTimeTableViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
        self.navigationController?.navigationBar.barTintColor = SystemColor.citySelectionBackgroundColor
        self.navigationController?.navigationBar.tintColor = SystemColor.orange
    }
    
    @objc func showCountryTableVC () {
        let countryTableVC: UIViewController = CountryTableViewController()
        let countryTableNC: UINavigationController = UINavigationController(rootViewController: countryTableVC)
        self.present(countryTableNC, animated: true)
    }
}

extension WorldTimeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
                timeInfoData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                completionHandler(true)
            }
        return UISwipeActionsConfiguration(actions: [deleteRow])
    }
}

extension WorldTimeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeInfoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorldTimeTableViewCell.identifer, for: indexPath) as? WorldTimeTableViewCell else {
            fatalError("Unable to dequeueReusableCell")
    }
        
        cell.timeDifferenceLabel.text =
        timeInfoData[indexPath.row].jetLag
        cell.dateStatusLabel.text =
        timeInfoData[indexPath.row].dateStatus
        
        cell.cityNameLabel.text      = timeInfoData[indexPath.row].cityName
        cell.nowTimeLabel.text       = timeInfoData[indexPath.row].currentTime
        cell.selectionStyle = .none
        
        return cell
    }
    
}


#Preview {
    UINavigationController(rootViewController: WorldTimeTableViewController())
}
