//
//  CountryTableViewController.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class CountryTableViewController: UIViewController {

    var tableView: UITableView = UITableView()
    let searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = SystemColor.citySelectionBackgroundColor
        
        configureTableView()
        addDelegateAndDataSource ()
        constraintTableView      ()
        configureSearchBar       ()
        
        self.navigationController?.navigationBar.backgroundColor = SystemColor.citySelectionBackgroundColor
        self.navigationItem.titleView?.backgroundColor = SystemColor.citySelectionBackgroundColor
        
    }
    
    func configureTableView() {
        tableView.rowHeight  = 45
        tableView.register(CitySelectionTableViewCell.nib(), forCellReuseIdentifier: CitySelectionTableViewCell.identifer)
        tableView.backgroundColor = SystemColor.citySelectionBackgroundColor
        tableView.separatorColor = SystemColor.darkGray
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.tableHeaderView = searchBar
    }
        
    
    func addDelegateAndDataSource () {
        tableView.delegate   = self
        tableView.dataSource = self
        searchBar.delegate   = self
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
        self.navigationController?.navigationBar.isHidden = true
        searchBar.delegate = self
        searchBar.tintColor       = SystemColor.orange
        searchBar.backgroundColor = SystemColor.citySelectionBackgroundColor
        searchBar.placeholder       = "Search"
        searchBar.searchBarStyle    = .minimal
        searchBar.showsCancelButton = true
        searchBar.prompt            = "Choose Country"
        searchBar.sizeToFit()
        searchBar.barTintColor      = SystemColor.orange
        searchBar.barStyle          = .black
    }
}

extension CountryTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        WorldTimeTableViewController.tableViewArray.append(indexPath.row)
        print(indexPath.row)
    }
}

extension CountryTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allTimeZone.count)
        return allTimeZone.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionTableViewCell.identifer, for: indexPath) as? CitySelectionTableViewCell else { fatalError()
        }
        cell.countryLabel.text = reserveRegionsName[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
}

extension CountryTableViewController: UISearchBarDelegate {
    
}



#Preview {
    UINavigationController(rootViewController: CountryTableViewController())
}
