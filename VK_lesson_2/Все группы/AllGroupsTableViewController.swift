//
//  AllGroupsTableViewController.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit

extension AllGroupsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
class AllGroupsTableViewController: UITableViewController,UISearchBarDelegate {
 
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allGroups = ["Актеры","Композиторы","Автомобили","Спорт","Путешествие","Экстрим","Политика"]
    var allGroupsFoto = ["Актеры":"Actors","Композиторы":"Composers","Автомобили":"Сars","Спорт":"Sport","Путешествие":"Travel","Экстрим":"Extrim","Политика":"Polit"]
    let searchController = UISearchController(searchResultsController: nil)
    var filteredAllGroups: [String] = []
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredAllGroups = allGroups.filter({(text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        // Filter the data array and get only those countries that match the search text.
//                filteredAllGroups = allGroups.filter({ (searchText) -> Bool in
//                    let groupsMatch: NSString = searchText as NSString
//
//                    return (groupsMatch.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
//                })
        
        searchActive = true
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchActive{
            return filteredAllGroups.count
        }
        
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as! AllGroupsCellTableViewCell
        var name = ""
        if searchActive {
             name = filteredAllGroups[indexPath.row]
        } else {
              name = allGroups[indexPath.row]
        }
        let result = allGroupsFoto.filter{(key,value) in key.contains(name) }
        cell.allGroupLogo.image = UIImage(named: result.first?.value ?? "")
        cell.allGroupName.text = result.first?.key
        
        

        return cell
    }
 
    // MARK: - Private instance methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
        searchActive = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
