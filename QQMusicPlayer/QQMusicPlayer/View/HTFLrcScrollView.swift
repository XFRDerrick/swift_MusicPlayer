//
//  HTFLrcScrollView.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/13.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

class HTFLrcScrollView: UIScrollView ,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
   
    var lrcLines: NSArray! = [HTFMusic]()
    
    var music: HTFMusic? {
        
       didSet{
            
            HTFLrcTool.setLrcWithMusic(music!)
            lrcLines = HTFLrcTool.lrcs()
        
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        
        tableView.contentInset = UIEdgeInsetsMake(self.tableView.frame.size.height * 0.5, 0, self.tableView.frame.size.height * 0.5, 0);
//        tableView.dataSource = self
        super.awakeFromNib()
        
        tableView.reloadData()

    }
    
    //tabView的数据源方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         print(lrcLines.count)
        return lrcLines.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        print(lrcLines.count)
        var cell = tableView.dequeueReusableCellWithIdentifier("LrcCell")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: "LrcCell")
        }
        
        let lrcLine: HTFLrcLine = lrcLines[indexPath.row] as! HTFLrcLine
        
        cell!.textLabel?.text = lrcLine.lrc
        
        print(lrcLine.lrc)
        
        return cell!
    }

}
