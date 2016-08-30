//
//  MyTableViewCell.swift
//  VisionGap
//
//  Created by absolute on 16/8/30.
//  Copyright © 2016年 Absolute. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    var constantGap:CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.clipsToBounds = true
        self.clipsToBounds = true
    
        constantGap = (2/1) * self.contentView.bounds.size.width / 2 - self.contentView.bounds.size.height/2
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyTableViewCell.scrollViewAnimation), name: "ScrollViewAnimation", object: nil)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func scrollViewAnimation(notification:NSNotification) {
        let directionStr:String = notification.object as! String
        var constant:CGFloat = self.centerYConstraint.constant
        
        if directionStr == "Up" {
            if constant < constantGap {
                constant += 1
            } else  if constant > constantGap {
                constant = constantGap
            }
            self.centerYConstraint.constant = constant
        } else if directionStr == "Down" {
            if constant > -1 * constantGap {
                constant -= 1
            } else  if constant < -1 * constantGap {
                constant = -1 * constantGap
            }
            self.centerYConstraint.constant = constant
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}
