//
//  HTFMusicTool.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/9.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

var _musics: NSArray? = [[String: HTFMusic]]()
var _music: HTFMusic?


class HTFMusicTool: NSObject {


   
    override class func initialize(){
        
       _musics = HTFMusic.objectWithFileName("Musics.plist")
        
    }
    
    class func musics() -> NSArray?{
        return _musics
    }

    class func nextMusic() {
    
        
        var index = _musics!.indexOfObject(_music!)

        if index == _musics!.count - 1 {
        
            index = 0
        }else{
        
            index = index + 1
        }

        let musicn = _musics![index]
        
        
        _music = musicn as? HTFMusic
        
    }
    
    class func previousMusic() {
        
        var index = _musics!.indexOfObject(_music!)

        if index == 0 {
            
            index = _musics!.count - 1
            
        }else{
            
            index = index - 1
        }
        
        let music = _musics![index]
        
        _music = music as? HTFMusic
        
    }
    
    class func setPlayingMusic(music: HTFMusic) {
        
        _music = music
    }
    
    class func playingMusic() -> HTFMusic {
        
        return _music!
    }
    
    
    
    
}
