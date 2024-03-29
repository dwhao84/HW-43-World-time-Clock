//
//  CountryTableViewController.swift
//  HW#43-World time Clock
//
//  Created by Da-wei Hao on 2024/1/6.
//

import UIKit

class CountryTableViewController: UIViewController  {

    var tableView: UITableView = UITableView()
    let searchBar: UISearchBar = UISearchBar()
    let searchController: UISearchController = UISearchController(searchResultsController: nil)

    lazy var filterTimeZoneData = allTimeZone
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = SystemColor.citySelectionBackgroundColor
        
        configureTableView()
        addDelegateAndDataSource ()
        constraintTableView      ()
        configureSearchController()
//        scrollViewDidScroll(tableView)
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

        searchController.delegate = self
        searchController.searchBar.delegate = self
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

    func configureSearchController () {

        let prompt: String = "Change Country"

        let scrollEdgeAppearance = self.navigationItem.scrollEdgeAppearance
        self.navigationController?.navigationItem.scrollEdgeAppearance = scrollEdgeAppearance

        self.navigationItem.searchController                  = searchController
        self.navigationItem.hidesSearchBarWhenScrolling       = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsCancelButton       = true

        searchController.searchResultsUpdater                 = self
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.searchBar.placeholder       = "Search"
        searchController.searchBar.prompt            = prompt
        searchController.searchBar.tintColor         = SystemColor.orange
        searchController.searchBar.returnKeyType     = .go
        searchController.searchBar.barStyle          = .black
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.isTranslucent     = false
        searchController.searchBar.searchBarStyle    = .default

        searchController.searchBar.searchTextField.textColor = SystemColor.white


        searchController.isActive  = true
        definesPresentationContext = true

        print("configureSearchBar success")
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
        return filterTimeZoneData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectionTableViewCell.identifer, for: indexPath) as? CitySelectionTableViewCell else { fatalError()
        }
        
        let cellOfCountryLabelText = reserveRegionsName[indexPath.row]
        cell.countryLabel.text = cellOfCountryLabelText
        cell.selectionStyle = .blue
        return cell
    }
}

extension CountryTableViewController: UISearchControllerDelegate, UISearchBarDelegate  {
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

extension CountryTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.isEmpty == false {
            filterTimeZoneData = allTimeZone.filter ({ cellOfCountryLabelText in
                cellOfCountryLabelText.description.localizedStandardContains(searchText)
                    })
                } else {
                    filterTimeZoneData = allTimeZone
                }
                tableView.reloadData()
        }
}

extension CountryTableViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let yOffset = scrollView.contentOffset.y

            if yOffset > 100 {
                print("Over than \(yOffset)")
                self.navigationItem.searchController?.searchBar.tintColor = SystemColor.orange
                navigationController?.navigationBar.barTintColor = SystemColor.black

            } else {
                print("Less than \(yOffset)")
                self.navigationItem.searchController?.searchBar.tintColor = SystemColor.orange
                navigationController?.navigationBar.barTintColor = SystemColor.black
            }
        }
}

#Preview {
    UINavigationController(rootViewController: CountryTableViewController())
}
