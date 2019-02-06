//
//  FriendsTableViewCell.swift
//  VK_lesson_2
//
//  Created by Чернецова Юлия on 12/01/2019.
//  Copyright © 2019 Чернецов Роман. All rights reserved.
//

import UIKit

  class FriendsTableViewCell: UITableViewCell {

   
  
    @IBOutlet weak var friendLogo: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    
 
    @IBOutlet weak var shadowView: UIView!

    

//    @IBInspectable var cornerRadius: CGFloat = 17 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    @IBInspectable var borderColor: UIColor = UIColor.black {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat = 2 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    




    override func layoutSubviews() {
        super.layoutSubviews()

        friendLogo.layer.cornerRadius = friendLogo.frame.height/2
        //friendLogo.clipsToBounds = true
        friendLogo.layer.masksToBounds = true
        friendLogo.layer.borderWidth = 2
        friendLogo.layer.borderColor = UIColor.white.cgColor
        
   
   }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
