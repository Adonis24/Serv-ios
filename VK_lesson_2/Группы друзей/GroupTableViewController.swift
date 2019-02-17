//
//  GroupTableViewController.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 07/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit
import Alamofire
class GroupTableViewController: UITableViewController {

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверяем идентификатор, чтобы убедится, что это нужный переход
        if segue.identifier == "addGroup" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            let allGroupsController = segue.source as! AllGroupsTableViewController
            
            // Получаем индекс выделенной ячейки
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                // Получаем группу по индексу
                let group = allGroupsController.allGroups[indexPath.row] 
                let groupFoto = allGroupsController.allGroupsFoto[group]
                // Добавляем город в список выбранных городов
                if !nameGroups.contains(group) {
                    nameGroups.append(group)
                
                    // Обновляем таблицу
                    groups[group] = groupFoto
                    tableView.reloadData()
                }
            }
            
        }
        
    }
    
    var nameGroups   = ["Актеры","Композиторы","Автомобили"]
    var groups = ["Актеры":"Actors","Композиторы":"Composers","Автомобили":"Сars"]
    var vkService = VKService()
    private var vk_groups = [Group]()
    @IBAction func apiGroups(_ sender: Any) {
        getGroups()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        vkService.getGroup(){ [weak self] groups, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            } else if let groups = groups, let self = self {
//                self.vk_groups = groups
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vkService.getGroup(){ [weak self] group, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let group = group, let self = self {
                self.vk_groups = group
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    @IBAction func backAuthGroup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getGroups(){
        let url = "https://api.vk.com"
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "access_token":Session.instance.token,
            "extended":"1",
            "count":"100",
            "v":"5.85"
        ]
        
        Alamofire.request(url+path, method: .get, parameters:parameters)
            .responseJSON{response in
                guard let value = response.value else {return}
                print(value)}
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vk_groups.count//nameGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
//        let name = nameGroups[indexPath.row]
//        let result = groups.filter{(key,value) in key.contains(name) }
     
//        cell.groupName.text = result.first?.key
//        cell.groupLogo.image = UIImage(named: result.first?.value ?? "")
         cell.configue(with: vk_groups[indexPath.row])
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
             let name = nameGroups[indexPath.row]
            nameGroups.remove(at: indexPath.row)
            groups.removeValue(forKey: name)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
 
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

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
