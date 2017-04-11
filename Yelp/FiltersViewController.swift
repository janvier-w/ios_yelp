//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Janvier Wijaya on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(
            _ filtersViewController: FiltersViewController,
            didUpdateFilters filters: [String : AnyObject])
}

class FiltersViewController: UIViewController {
    weak var delegate: FiltersViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!

    let CellIdentifier = "TableViewCell"
    let HeaderViewIdentifier = "TableViewHeaderView"

    let availableDeals: [String] = [
        "Offering a Deal"
    ]
    let availableDistances: [String] = [
        "Best Matched",
        "0.3 miles",
        "1 mile",
        "5 miles",
        "20 miles"
    ]
    let availableSortCriteria: [String] = [
        "Best Matched",
        "Distance",
        "Highest Rated"
    ]
    let availableCategories: [[String : String]] = [
        ["name" : "Afghan", "code" : "afghani"],
        ["name" : "African", "code" : "african"],
        ["name" : "American, New", "code" : "newamerican"],
        ["name" : "American, Traditional", "code" : "tradamerican"],
        ["name" : "Arabian", "code" : "arabian"],
        ["name" : "Argentine", "code" : "argentine"],
        ["name" : "Armenian", "code" : "armenian"],
        ["name" : "Asian Fusion", "code" : "asianfusion"],
        ["name" : "Asturian", "code" : "asturian"],
        ["name" : "Australian", "code" : "australian"],
        ["name" : "Austrian", "code" : "austrian"],
        ["name" : "Baguettes", "code" : "baguettes"],
        ["name" : "Bangladeshi", "code" : "bangladeshi"],
        ["name" : "Barbeque", "code" : "bbq"],
        ["name" : "Basque", "code" : "basque"],
        ["name" : "Bavarian", "code" : "bavarian"],
        ["name" : "Beer Garden", "code" : "beergarden"],
        ["name" : "Beer Hall", "code" : "beerhall"],
        ["name" : "Beisl", "code" : "beisl"],
        ["name" : "Belgian", "code" : "belgian"],
        ["name" : "Bistros", "code" : "bistros"],
        ["name" : "Black Sea", "code" : "blacksea"],
        ["name" : "Brasseries", "code" : "brasseries"],
        ["name" : "Brazilian", "code" : "brazilian"],
        ["name" : "Breakfast & Brunch", "code" : "breakfast_brunch"],
        ["name" : "British", "code" : "british"],
        ["name" : "Buffets", "code" : "buffets"],
        ["name" : "Bulgarian", "code" : "bulgarian"],
        ["name" : "Burgers", "code" : "burgers"],
        ["name" : "Burmese", "code" : "burmese"],
        ["name" : "Cafes", "code" : "cafes"],
        ["name" : "Cafeteria", "code" : "cafeteria"],
        ["name" : "Cajun/Creole", "code" : "cajun"],
        ["name" : "Cambodian", "code" : "cambodian"],
        ["name" : "Canadian", "code" : "New)"],
        ["name" : "Canteen", "code" : "canteen"],
        ["name" : "Caribbean", "code" : "caribbean"],
        ["name" : "Catalan", "code" : "catalan"],
        ["name" : "Chech", "code" : "chech"],
        ["name" : "Cheesesteaks", "code" : "cheesesteaks"],
        ["name" : "Chicken Shop", "code" : "chickenshop"],
        ["name" : "Chicken Wings", "code" : "chicken_wings"],
        ["name" : "Chilean", "code" : "chilean"],
        ["name" : "Chinese", "code" : "chinese"],
        ["name" : "Comfort Food", "code" : "comfortfood"],
        ["name" : "Corsican", "code" : "corsican"],
        ["name" : "Creperies", "code" : "creperies"],
        ["name" : "Cuban", "code" : "cuban"],
        ["name" : "Curry Sausage", "code" : "currysausage"],
        ["name" : "Cypriot", "code" : "cypriot"],
        ["name" : "Czech", "code" : "czech"],
        ["name" : "Czech/Slovakian", "code" : "czechslovakian"],
        ["name" : "Danish", "code" : "danish"],
        ["name" : "Delis", "code" : "delis"],
        ["name" : "Diners", "code" : "diners"],
        ["name" : "Dumplings", "code" : "dumplings"],
        ["name" : "Eastern European", "code" : "eastern_european"],
        ["name" : "Ethiopian", "code" : "ethiopian"],
        ["name" : "Fast Food", "code" : "hotdogs"],
        ["name" : "Filipino", "code" : "filipino"],
        ["name" : "Fish & Chips", "code" : "fishnchips"],
        ["name" : "Fondue", "code" : "fondue"],
        ["name" : "Food Court", "code" : "food_court"],
        ["name" : "Food Stands", "code" : "foodstands"],
        ["name" : "French", "code" : "french"],
        ["name" : "French Southwest", "code" : "sud_ouest"],
        ["name" : "Galician", "code" : "galician"],
        ["name" : "Gastropubs", "code" : "gastropubs"],
        ["name" : "Georgian", "code" : "georgian"],
        ["name" : "German", "code" : "german"],
        ["name" : "Giblets", "code" : "giblets"],
        ["name" : "Gluten-Free", "code" : "gluten_free"],
        ["name" : "Greek", "code" : "greek"],
        ["name" : "Halal", "code" : "halal"],
        ["name" : "Hawaiian", "code" : "hawaiian"],
        ["name" : "Heuriger", "code" : "heuriger"],
        ["name" : "Himalayan/Nepalese", "code" : "himalayan"],
        ["name" : "Hong Kong Style Cafe", "code" : "hkcafe"],
        ["name" : "Hot Dogs", "code" : "hotdog"],
        ["name" : "Hot Pot", "code" : "hotpot"],
        ["name" : "Hungarian", "code" : "hungarian"],
        ["name" : "Iberian", "code" : "iberian"],
        ["name" : "Indian", "code" : "indpak"],
        ["name" : "Indonesian", "code" : "indonesian"],
        ["name" : "International", "code" : "international"],
        ["name" : "Irish", "code" : "irish"],
        ["name" : "Island Pub", "code" : "island_pub"],
        ["name" : "Israeli", "code" : "israeli"],
        ["name" : "Italian", "code" : "italian"],
        ["name" : "Japanese", "code" : "japanese"],
        ["name" : "Jewish", "code" : "jewish"],
        ["name" : "Kebab", "code" : "kebab"],
        ["name" : "Korean", "code" : "korean"],
        ["name" : "Kosher", "code" : "kosher"],
        ["name" : "Kurdish", "code" : "kurdish"],
        ["name" : "Laos", "code" : "laos"],
        ["name" : "Laotian", "code" : "laotian"],
        ["name" : "Latin American", "code" : "latin"],
        ["name" : "Live/Raw Food", "code" : "raw_food"],
        ["name" : "Lyonnais", "code" : "lyonnais"],
        ["name" : "Malaysian", "code" : "malaysian"],
        ["name" : "Meatballs", "code" : "meatballs"],
        ["name" : "Mediterranean", "code" : "mediterranean"],
        ["name" : "Mexican", "code" : "mexican"],
        ["name" : "Middle Eastern", "code" : "mideastern"],
        ["name" : "Milk Bars", "code" : "milkbars"],
        ["name" : "Modern Australian", "code" : "modern_australian"],
        ["name" : "Modern European", "code" : "modern_european"],
        ["name" : "Mongolian", "code" : "mongolian"],
        ["name" : "Moroccan", "code" : "moroccan"],
        ["name" : "New Zealand", "code" : "newzealand"],
        ["name" : "Night Food", "code" : "nightfood"],
        ["name" : "Norcinerie", "code" : "norcinerie"],
        ["name" : "Open Sandwiches", "code" : "opensandwiches"],
        ["name" : "Oriental", "code" : "oriental"],
        ["name" : "Pakistani", "code" : "pakistani"],
        ["name" : "Parent Cafes", "code" : "eltern_cafes"],
        ["name" : "Parma", "code" : "parma"],
        ["name" : "Persian/Iranian", "code" : "persian"],
        ["name" : "Peruvian", "code" : "peruvian"],
        ["name" : "Pita", "code" : "pita"],
        ["name" : "Pizza", "code" : "pizza"],
        ["name" : "Polish", "code" : "polish"],
        ["name" : "Portuguese", "code" : "portuguese"],
        ["name" : "Potatoes", "code" : "potatoes"],
        ["name" : "Poutineries", "code" : "poutineries"],
        ["name" : "Pub Food", "code" : "pubfood"],
        ["name" : "Rice", "code" : "riceshop"],
        ["name" : "Romanian", "code" : "romanian"],
        ["name" : "Rotisserie Chicken", "code" : "rotisserie_chicken"],
        ["name" : "Rumanian", "code" : "rumanian"],
        ["name" : "Russian", "code" : "russian"],
        ["name" : "Salad", "code" : "salad"],
        ["name" : "Sandwiches", "code" : "sandwiches"],
        ["name" : "Scandinavian", "code" : "scandinavian"],
        ["name" : "Scottish", "code" : "scottish"],
        ["name" : "Seafood", "code" : "seafood"],
        ["name" : "Serbo Croatian", "code" : "serbocroatian"],
        ["name" : "Signature Cuisine", "code" : "signature_cuisine"],
        ["name" : "Singaporean", "code" : "singaporean"],
        ["name" : "Slovakian", "code" : "slovakian"],
        ["name" : "Soul Food", "code" : "soulfood"],
        ["name" : "Soup", "code" : "soup"],
        ["name" : "Southern", "code" : "southern"],
        ["name" : "Spanish", "code" : "spanish"],
        ["name" : "Steakhouses", "code" : "steak"],
        ["name" : "Sushi Bars", "code" : "sushi"],
        ["name" : "Swabian", "code" : "swabian"],
        ["name" : "Swedish", "code" : "swedish"],
        ["name" : "Swiss Food", "code" : "swissfood"],
        ["name" : "Tabernas", "code" : "tabernas"],
        ["name" : "Taiwanese", "code" : "taiwanese"],
        ["name" : "Tapas Bars", "code" : "tapas"],
        ["name" : "Tapas/Small Plates", "code" : "tapasmallplates"],
        ["name" : "Tex-Mex", "code" : "tex-mex"],
        ["name" : "Thai", "code" : "thai"],
        ["name" : "Traditional Norwegian", "code" : "norwegian"],
        ["name" : "Traditional Swedish", "code" : "traditional_swedish"],
        ["name" : "Trattorie", "code" : "trattorie"],
        ["name" : "Turkish", "code" : "turkish"],
        ["name" : "Ukrainian", "code" : "ukrainian"],
        ["name" : "Uzbek", "code" : "uzbek"],
        ["name" : "Vegan", "code" : "vegan"],
        ["name" : "Vegetarian", "code" : "vegetarian"],
        ["name" : "Venison", "code" : "venison"],
        ["name" : "Vietnamese", "code" : "vietnamese"],
        ["name" : "Wok", "code" : "wok"],
        ["name" : "Wraps", "code" : "wraps"],
        ["name" : "Yugoslav", "code" : "yugoslav"]
    ]
    var filters: [AnyObject]!

    var selectedDeal = false

    var isDistanceCollapsed = true
    var selectedDistance = 0

    var isSortCriteriaCollapsed = true
    var selectedSortCriterion = 0

    var selectedCategories = [Int : Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                forCellReuseIdentifier: CellIdentifier)
        tableView.register(UITableViewHeaderFooterView.self,
                forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)

        filters = [
            ("DEAL", availableDeals) as AnyObject,
            ("DISTANCE", availableDistances) as AnyObject,
            ("SORT BY", availableSortCriteria) as AnyObject,
            ("CATEGORY", availableCategories) as AnyObject
        ]
    }

    @IBAction func cancelSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func performSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)

        var appliedFilters = [String : AnyObject]()

        // Set deal filter
        appliedFilters["deal"] = selectedDeal as AnyObject

        // Set distance filter
        var selectedDistanceValue = 0
        if selectedDistance == 1 {
            selectedDistanceValue = Int(round(0.3 / 0.000621371))
        } else if selectedDistance == 2 {
            selectedDistanceValue = Int(round(1.0 / 0.000621371))
        } else if selectedDistance == 3 {
            selectedDistanceValue = Int(round(5.0 / 0.000621371))
        } else if selectedDistance == 4 {
            selectedDistanceValue = Int(round(20.0 / 0.000621371))
        }
        if selectedDistance != 0 {
            appliedFilters["distance"] = selectedDistanceValue as AnyObject
        }
        
        // Set sort criterion filter
        appliedFilters["sort_by"] = selectedSortCriterion as AnyObject

        // Set category filter
        var selectedCodeCategories = [String]()
        for (row, isSelected) in selectedCategories {
            if isSelected {
                selectedCodeCategories.append(availableCategories[row]["code"]!)
            }
        }
        appliedFilters["category"] = selectedCodeCategories as AnyObject

        delegate?.filtersViewController?(self, didUpdateFilters: appliedFilters)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FiltersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
            -> Int {
        let (criteriaName, criteria) = filters[section]
                as! (String, [AnyObject])
        if criteriaName == "DISTANCE" && isDistanceCollapsed {
            return 1
        } else if criteriaName == "SORT BY" && isSortCriteriaCollapsed {
            return 1
        }

        return criteria.count
    }

    func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: HeaderViewIdentifier)!
        let (criteriaName, _) = filters[section] as! (String, [AnyObject])
        header.textLabel?.text = criteriaName

        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
            -> UITableViewCell {
        let (criteriaName, criteria) = filters[indexPath.section]
                as! (String, [AnyObject])
        if criteriaName == "DEAL" {
            let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.delegate = self
            cell.controlLabel.text = criteria[indexPath.row] as? String
            cell.controlSwitch.isOn = selectedDeal

            return cell
        } else if criteriaName == "DISTANCE" {
            let cell = tableView.dequeueReusableCell(
                    withIdentifier: "RadioCell", for: indexPath) as! RadioCell
            if isDistanceCollapsed {
                cell.controlLabel.text = criteria[selectedDistance] as? String
                cell.controlImageView.image = UIImage(named: "arrow_down")
            } else {
                cell.controlLabel.text = criteria[indexPath.row] as? String
                cell.controlImageView.image =
                        (indexPath.row == selectedDistance) ?
                        UIImage(named: "radio_checked") :
                        UIImage(named: "radio_unchecked")
            }

            return cell
        } else if criteriaName == "SORT BY" {
            let cell = tableView.dequeueReusableCell(
                    withIdentifier: "RadioCell", for: indexPath) as! RadioCell
            if isSortCriteriaCollapsed {
                cell.controlLabel.text = criteria[selectedSortCriterion]
                        as? String
                cell.controlImageView.image = UIImage(named: "arrow_down")
            } else {
                cell.controlLabel.text = criteria[indexPath.row] as? String
                cell.controlImageView.image =
                        (indexPath.row == selectedSortCriterion) ?
                        UIImage(named: "radio_checked") :
                        UIImage(named: "radio_unchecked")
            }

            return cell
        } else if criteriaName == "CATEGORY" {
            let criterion = criteria[indexPath.row] as! [String : String]
            let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.delegate = self
            cell.controlLabel.text = criterion["name"]
            cell.controlSwitch.isOn = selectedCategories[indexPath.row] ?? false

            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView,
            heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 0 : 66
    }

    func tableView(_ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath) {
        let (criteriaName, _) = filters[indexPath.section]
                as! (String, [AnyObject])
        if criteriaName == "DISTANCE" {
            if !isDistanceCollapsed {
                selectedDistance = indexPath.row
            }
            isDistanceCollapsed = !isDistanceCollapsed
            tableView.reloadData()
        } else if criteriaName == "SORT BY" {
            if !isSortCriteriaCollapsed {
                selectedSortCriterion = indexPath.row
            }
            isSortCriteriaCollapsed = !isSortCriteriaCollapsed
            tableView.reloadData()
        }
    }
}

// MARK: - SwitchCellDelegate
extension FiltersViewController: SwitchCellDelegate {
    func switchCell(_ switchCell: SwitchCell,
            didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        if indexPath.section == 0 {
            selectedDeal = value
        } else if indexPath.section == 3 {
            selectedCategories[indexPath.row] = value
        }
    }
}
