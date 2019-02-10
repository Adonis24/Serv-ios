//
//  FriendsTableViewController.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 07/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit
import Alamofire

class FriendsTableViewController: UITableViewController {
   
    
    
    var names   = ["Брэдли Купер","Рассел Кроу","Ричард Гир","Леонардо ди Каприо"]
    var friends = ["Брэдли Купер":"Bredly","Рассел Кроу":"Russel","Ричард Гир":"Richard","Леонардо ди Каприо":"Leonardo"]
    var friendsFoto = ["Bredly":"Брэдли Купер","Bredly_1":"Брэдли Купер","Russel":"Рассел Кроу","Russel_1":"Рассел Кроу","Richard":"Ричард Гир","Richard_1":"Ричард Гир","Leonardo":"Леонардо ди Каприо","Leonardo_1":"Леонардо ди Каприо"]
    var characters = ["Б","Р","Л"]
    var filtredCharacters = [""]
   let searchController = UISearchController(searchResultsController: nil)
 
  var searchActive : Bool = false
  var filteredAllFriends: [String] = []
 var  allFriendsCharacter = [""]
 
    @IBAction func apiFriends(_ sender: Any) {
       getFriends()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupSearchController()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func getFriends()  {
        let url = "https://api.vk.com"
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token":Session.instance.token,
            "order":"name",
            "fields":"city",
            "v":"5.85"
        ]
        
        Alamofire.request(url+path, method: .get, parameters:parameters)
            .responseJSON{response in
                guard let value = response.value else {return}
                print(value)
        }
    }
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Names"
        searchController.searchBar.isHidden = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    @IBAction func backAuthFriends(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Search
    
    

    //Search
    // * data sourse start
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if isFiltering() {
            return filtredCharacters.count
        } else {
            return characters.count
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if isFiltering() {
            return filteredAllFriends.count
        } else {
            return  names.filter {$0[$0.startIndex] == Character(characters[section]) }.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        var name = ""
     

        if isFiltering() {
     
             name = filteredAllFriends[indexPath.row]
 
        } else {
            name =   names.filter {$0[$0.startIndex] == Character(characters[indexPath.section]) }[indexPath.row]
        }
        let result = friends.filter{(key,value) in key.contains(name) }
        cell.friendLogo.image = UIImage(named: result.first?.value ?? "")
        cell.friendName.text = result.first?.key

        // Configure the cell...
        

        return cell
    }
    
    //* data source end
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isFiltering() { return 0} else {
            return CGFloat(25)
        }
    }
 //Titles section
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isFiltering() { return [""]} else {
            return characters
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFiltering() {return nil} else {
        let viewHeader = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableView.bounds.width, height: 25)))
        viewHeader.backgroundColor = tableView.backgroundColor
        viewHeader.alpha = 0.5
        //add label header start
        let headerL = UILabel(frame: CGRect(x: 20, y: 8, width: 50, height: 20))
        headerL.textAlignment = .center
        headerL.font = UIFont.italicSystemFont(ofSize: CGFloat(14))
        headerL.text = characters[section]
        viewHeader.addSubview(headerL)
        //add label header stop
        return viewHeader
        }
    }
    //transfer fotos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allFotoFriend" {
            let fotoFriendsController  = segue.destination as! FriendFotos
            let myFriendsController = segue.source as! FriendsTableViewController
            //  Получаем индекс выделенной ячейки
            
            if let indexPath = myFriendsController.tableView.indexPathForSelectedRow {
                
                // Получаем друга по индексу
                var allFotoOneFriend = [String]()
                //let friendName = myFriendsController.names[indexPath.row]
               let friendName =   myFriendsController.names.filter {$0[$0.startIndex] == Character(characters[indexPath.section]) }[indexPath.row]
                let result = friendsFoto.filter{(key,value) in value.contains(friendName) }
                for elem in result {
                  allFotoOneFriend.append(elem.key)
                }
               
                    fotoFriendsController.allFotoOneFriend = allFotoOneFriend
                
            }
        }
    }
    
    
    func filterNames (from names: [String], in section: Int) -> [String] {
        let key = firstLetters(in: names)[section]
        return names.filter {$0.first! == Character(key)}
    }
    
    func firstLetters (in names: [String]) -> [String] {
        let keys = [String](names)
        var firstLetters: [String] = []
        for key in keys {
            firstLetters.append(String(key.first!))
        }
        return firstLetters//Array(Set(firstLetters))
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredAllFriends = names.filter({( name ) -> Bool in
            return name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //    // Setup the Scope Bar
//    searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
//    searchController.searchBar.delegate = self
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
extension FriendsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
