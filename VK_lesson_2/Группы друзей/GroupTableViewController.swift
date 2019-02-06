//
//  GroupTableViewController.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 07/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func backAuthGroup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        let name = nameGroups[indexPath.row]
        let result = groups.filter{(key,value) in key.contains(name) }
     
        cell.groupName.text = result.first?.key
        cell.groupLogo.image = UIImage(named: result.first?.value ?? "")
        
//        let border = UIView()
//        border.frame = cell.groupLogo.bounds
//        border.layer.cornerRadius = cell.groupLogo.bounds.height / 2
//        border.layer.masksToBounds = true
//        cell.groupLogo.addSubview(border)
//     
//        
//        let newFriendAvatar = UIImageView()
//        newFriendAvatar.image = UIImage(named: result.first?.value ?? "")
//        
//        newFriendAvatar.frame = border.bounds
//        border.addSubview(newFriendAvatar)
        
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
