//
//  MusicTableViewCell.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/6.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    var music: HTFMusic?{
        
        didSet{
            
            iconImageView.image = UIImage(named: music!.singerIcon!)
            nameLable.text = music!.name
            singerNameLable.text = music?.singer
            
        }
        
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var singerNameLable: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //设置圆角半径图片的
        iconImageView.layer.cornerRadius = 24
        iconImageView.clipsToBounds = true
        //设置边框
        iconImageView.layer.borderWidth = 3
        iconImageView.layer.borderColor = UIColor.purpleColor().CGColor
        
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
