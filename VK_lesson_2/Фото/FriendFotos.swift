//
//  FriendFotos.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class FriendFotos: UIViewController {
    
    var vkService = VKService()
    var allFotoOneFriend = [Photo]()
    var listPhoto = [Photo]()
    var myFriendId: Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func apiFotos(_ sender: UIBarButtonItem) {
        getFotos(owner_id: allFotoOneFriend[0].id)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listPhoto = [Photo]()
        vkService.getFoto(owner_id: myFriendId, completion: { [weak self] photos,error in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let photos = photos, let self = self {
                self.allFotoOneFriend = photos
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    func getFotos(owner_id: Int)  {
        
        let url = "https://api.vk.com"
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "access_token":Session.instance.token,
            "owner_id": owner_id,
            "photo_sizes": 1,
            "v":"5.85"
        ]
        
        Alamofire.request(url+path, method: .get, parameters:parameters)
            .responseJSON{response in
                guard let value = response.value else {return}
                print(value)
        }
    }
    
}
extension FriendFotos: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allFotoOneFriend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var url_photo = ""
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendFotos", for: indexPath) as! FriendFotoCell
        let photo = self.allFotoOneFriend[indexPath.row]
        url_photo = photo.url
        cell.friendFotos.kf.setImage(with: URL(string: url_photo))
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
}



