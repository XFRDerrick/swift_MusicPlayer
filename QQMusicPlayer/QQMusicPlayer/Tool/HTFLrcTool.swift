//
//  HTFLrcTool.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/13.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import Foundation

var lrcLines: NSArray! = [String]()

class HTFLrcTool: NSObject {
    
    //返回歌词模型数组
    class func lrcs() -> NSArray{
    
        return lrcLines
    }
    
    //解析歌词存入模型数组
    class func setLrcWithMusic(music: HTFMusic) {
    
        //创建可变的数组
        let tempArr = NSMutableArray()
        
        let path = NSBundle.mainBundle().pathForResource(music.lrcname, ofType: nil)!
        
        let url = NSURL(fileURLWithPath: path)
        
        let lrcString = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        
        let arrLrcs = lrcString.componentsSeparatedByString("\n")
        
        //遍历
        for i in 0 ..< arrLrcs.count {
        
            let str = arrLrcs[i] as NSString
            
            if !str.hasPrefix("[0") {
            
                continue
            }
            
            //歌词和时间的截取
            
            let range: NSRange = NSMakeRange(1, 8)
            
            let time = str.substringWithRange(range)
            
            let lrc = str.substringFromIndex(10)
            
            
            let lrcLine = HTFLrcLine()
            
            lrcLine.time = time
            lrcLine.lrc = lrc
            
            tempArr.addObject(lrcLine)
            
        }
        lrcLines = tempArr
        
        
    }
    
    
    
}
