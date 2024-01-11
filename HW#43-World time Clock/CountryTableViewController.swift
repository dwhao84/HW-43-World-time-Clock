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

    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = SystemColor.citySelectionBackgroundColor
        
        configureTableView()
        addDelegateAndDataSource ()
        constraintTableView      ()
        configureSearchBar       ()
    }
    
    
    func configureTableView() {
        tableView.rowHeight  = 45
        tableView.register(CitySelectionTableViewCell.nib(), forCellReuseIdentifier: CitySelectionTableViewCell.identifer)
        tableView.backgroundColor = SystemColor.citySelectionBackgroundColor
        tableView.separatorColor  = SystemColor.darkGray
        tableView.separatorStyle  = .singleLine
        tableView.allowsSelection = true
    }
        
    
    func addDelegateAndDataSource () {
        tableView.delegate   = self
        tableView.dataSource = self
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
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchBar.prompt = "Choose Country"
        self.searchBar.text   = "Search"
        self.navigationItem.titleView?.tintColor = SystemColor.orange
        searchBar.sizeToFit()
    }
}

extension CountryTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedTimeZone = allTimeZone[indexPath.row]
        
        let newTimeInfo = TimeInfo(currentTime: getCurrentTime(city: selectedTimeZone),
                                   jetLag: calculateTimeDifference(city: selectedTimeZone),
                                   cityName: getCityName(cityName: selectedTimeZone),
                                   dateStatus: calculateTheDate(city: selectedTimeZone))
        timeInfoData.append(newTimeInfo)
        WorldTimeTableViewController.tableView.reloadData()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.tintColor         = SystemColor.orange
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.tintColor         = SystemColor.orange
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
}

extension CountryTableViewController: UISearchControllerDelegate {
    
}

#Preview {
    UINavigationController(rootViewController: CountryTableViewController())
}
