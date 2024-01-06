//
//  CountryTableViewController.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class CountryTableViewController: UIViewController {

    var tableView: UITableView = UITableView()
    let searchBarController: UISearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = SystemColor.citySelectionBackgroundColor
        view.tintColor       = SystemColor.orange
        
        configureTableView()
        addDelegateAndDataSource ()
        constraintTableView      ()
        configureSearchBar       ()
        
        self.navigationController?.navigationBar.backgroundColor = SystemColor.citySelectionBackgroundColor
        self.navigationItem.titleView?.backgroundColor = SystemColor.citySelectionBackgroundColor
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureTableView() {
        tableView.rowHeight  = 45
        tableView.register(CitySelectionTableViewCell.nib(), forCellReuseIdentifier: CitySelectionTableViewCell.identifer)
        tableView.backgroundColor = SystemColor.citySelectionBackgroundColor
        
        tableView.separatorColor = SystemColor.darkGray
        tableView.separatorStyle = .singleLine
        
        tableView.allowsSelection = true
        print(timeZoneArray)
        }
        
    
    func addDelegateAndDataSource () {
        tableView.delegate           = self
        tableView.dataSource         = self
//        searchBarController.delegate = self
    }
    
    func constraintTableView () {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureSearchBar () {
        self.navigationItem.searchController               = searchBarController
        searchBarController.isActive                       = true
        searchBarController.searchBar.showsCancelButton    = true
        searchBarController.searchBar.tintColor            = SystemColor.orange
        searchBarController.automaticallyShowsCancelButton = true
        
    }
}

extension CountryTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        WorldTimeTableViewController.tableViewArray.append(indexPath.row)
        print(WorldTimeTableViewController.tableViewArray)
    }
}

extension CountryTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionTableViewCell.identifer, for: indexPath) as? CitySelectionTableViewCell else { fatalError()
        }
        cell.countryLabel.text = timeZoneArray[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
}

extension CountryTableViewController: UISearchControllerDelegate {
    
}



#Preview {
    UINavigationController(rootViewController: CountryTableViewController())
}
