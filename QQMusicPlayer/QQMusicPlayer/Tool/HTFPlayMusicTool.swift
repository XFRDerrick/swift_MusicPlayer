//
//  HTFPlayMusicTool.swift
//  swift_playMusic
//
//  Created by 赫腾飞 on 16/1/5.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

import AVFoundation

var players: Dictionary? = [String: AVAudioPlayer]()

class HTFPlayMusicTool: NSObject {
    
    //存放音乐的数组
    //MARK:- 播放音乐With Name
    class func playMusicWithName(name: String) -> AVAudioPlayer{
    
        var player: AVAudioPlayer? = players![name]
        
        if player == nil {
            
            let path = NSBundle.mainBundle().pathForResource(name, ofType: nil)
            
            let url = NSURL(fileURLWithPath: path!)
            
            player = try! AVAudioPlayer(contentsOfURL: url)
            
            players![name] = player
            
        }
        //TODO:- 全局断点会再此处停止为什么？？？
        if ((player?.play()) != nil) {
            player?.play()
        }
        
        return player!
        
    }
    //暂停音乐
   class func pauseMusicWithName(name: String){
        
        let player = players![name]
        
        if (player != nil) {
        
            player?.pause()
        }
    
    }
    //停止音乐
   class func stopMusicWithName(name: String){
        
        var player = players![name]
        
        if (player != nil) {
            
            //TODO:- 全局断点会再此处停止为什么？？？
            player?.stop()
            player = nil
            
            players?.removeValueForKey(name)
        }
    
    
    }
    
    
}
