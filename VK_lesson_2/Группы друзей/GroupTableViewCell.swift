//
//  GroupTableViewCell.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupLogo: UIImageView!
//        didSet {
//            groupLogo.layer.borderColor = UIColor.white.cgColor
//            groupLogo.layer.borderWidth = 2
//        }
//    }
    
    @IBOutlet weak var groupName: UILabel!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        groupName.text = nil
//        groupLogo.image = nil
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        groupLogo.clipsToBounds = true
//        groupLogo.layer.cornerRadius = groupLogo.frame.width/2
//
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
