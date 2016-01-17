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
    
    var currentTime: NSTimeInterval!{
    
        didSet{
        
            lrcScroll(currentTime)
        }
        
    }
    
    var music: HTFMusic? {
        
       didSet{
            
            HTFLrcTool.setLrcWithMusic(music!)
            lrcLines = HTFLrcTool.lrcs()
            //刷新数据
            tableView.reloadData()
            //更换歌曲后 滚动到歌词第一行
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.None, animated: false)
        }
    }
    
    override func awakeFromNib() {
        
        //设置内边距
        tableView.contentInset = UIEdgeInsetsMake(self.tableView.frame.size.height * 0.5, 0, self.tableView.frame.size.height * 0.5, 0);
        
        super.awakeFromNib()
        
        
    }
    
    //MARK:- 歌词跟随滚动的方法
    private func lrcScroll(currentTime: NSTimeInterval!){
    
        
        let currentTimeStr = setUpTime(currentTime)
        
        
        for i in 0 ..< lrcLines.count {
        
            let lrcLine = lrcLines![i] as! HTFLrcLine
            
            let time = lrcLine.time
            
            if i + 1 <= lrcLines.count - 1 {
            
                let nextLrc = lrcLines[i + 1] as! HTFLrcLine
                
                let nextTime = nextLrc.time
                
                //比较时间字符串
                if currentTimeStr.compare(time) == .OrderedDescending && currentTimeStr.compare(nextTime) == .OrderedAscending {
                
                    tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0), atScrollPosition: UITableViewScrollPosition.None, animated: false)
                    
                }
                
            }
            
            
        }
        
    }
    
    
    //MARK:- tabView的数据源方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcLines.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("LrcCell")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: "LrcCell")
        }
        //获取数据模型
        let lrcLine: HTFLrcLine = lrcLines[indexPath.row] as! HTFLrcLine
        //设置数据的属性
        cell!.textLabel?.text = lrcLine.lrc
        cell?.textLabel?.textAlignment = .Center
        cell?.backgroundColor = UIColor.clearColor()
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.selectionStyle = .None
        
        return cell!
    }
    
    //MARK:- 将时间转换成字符串
    private func setUpTime(time: NSTimeInterval) -> String{
        
        let minute = Int(time / 60)
        
        let second = Int(time % 60)
        
        let msecond = Int(time - Double(Int(time)) * 100)
        
        let str = String(format: "%02d" + ":" + "%02d" + ".%02d", minute,second,msecond)//"\(minute)" + ":" + "\(second)"
        
        return str
        
    }

}
