//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var searchController: UISearchController!

    var businesses: [Business]!
    var filteredBusinesses: [Business]!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        /* Initialize with searchResultsController set to nil means that the
         * searchController will use this VC to display the search results
         */
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        /* It does not make sense to dim the same VC that presents the search
         * results. This should maybe be set to true when another VC presents
         * the search results instead.
         */
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        /*
        tableView.tableHeaderView = searchController.searchBar
        */
        /* Place the search bar inside the navigation bar */
        navigationItem.titleView = searchController.searchBar

        /* Prevent the default setting which hides the navigation bar when
         * presenting the search interface
         */
        searchController.hidesNavigationBarDuringPresentation = false
        
        /* Set this VC as the presenting VC for the search interface */
        definesPresentationContext = true

        Business.searchWithTerm(term: "Thai")
                { (businesses: [Business]?, error: Error?) in
                    self.businesses = businesses
                    self.filteredBusinesses = businesses
                    self.tableView.reloadData()
                    /*
                    if let businesses = businesses {
                        for business in businesses {
                            print(business.name!)
                            print(business.address!)
                            print(business.imageURL!)
                            print(business.categories!)
                            print(business.distance!)
                            print(business.ratingImageURL!)
                            print(business.reviewCount!)
                            print("")
                        }
                    }
                    */
                }
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as!
                FiltersViewController
        filtersViewController.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
            -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses!.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell",
                for: indexPath) as! BusinessCell
        cell.business = filteredBusinesses[indexPath.row]

        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension BusinessesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let queryText = searchController.searchBar.text {
            filteredBusinesses = queryText.isEmpty ?
                    businesses :
                    businesses.filter { (business: Business) -> Bool in
                        return business.contains(keyword: queryText)
                    }
            tableView.reloadData()
        }
    }
}

// MARK: - FiltersViewControllerDelegate
extension BusinessesViewController: FiltersViewControllerDelegate {
    func filtersViewController(_ filtersViewController: FiltersViewController,
            didUpdateFilters filters: [String : AnyObject]) {
        let deals = filters["deal"] as? Bool
        let distance = filters["distance"] as? Int
        let sortCriterion = filters["sort_by"] as? Int
        let categories = filters["category"] as? [String]
        Business.searchWithTerm(term: "Restaurants", distance: distance,
                sort: YelpSortMode(rawValue: sortCriterion!),
                categories: categories, deals: deals)
                { (businesses: [Business]?, error: Error?) in
                    self.businesses = businesses
                    self.filteredBusinesses = businesses
                    self.tableView.reloadData()
                }
    }
}
