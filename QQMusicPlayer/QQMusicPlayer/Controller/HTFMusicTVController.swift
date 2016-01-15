//
//  HTFMusicTVController.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/6.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

class HTFMusicTVController: UITableViewController {


    var playVC: PlayViewController? = PlayViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        
        //        tableView.rowHeight = UITableViewAutomaticDimension;
        
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg3")!)
        
        tableView.separatorStyle = .None
        //
        //        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height))
        //        bgImageView.image = UIImage(named: "bgbg")
        //        tableView.backgroundView?.addSubview(bgImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musics.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MusicTableViewCell") as! MusicTableViewCell

        let music = musics[indexPath.row] as! HTFMusic
        
        cell.music = music
        
        return cell
    }

    //MARK:- 点击Cell跳转页面
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let musicNow = HTFMusicTool.musics()![indexPath.row]
        
        HTFMusicTool.setPlayingMusic(musicNow as! HTFMusic)
        
        self.playVC!.show()
        
    }
    
    
    //获取数据
    var musics:NSArray {
        
           let music = HTFMusic.objectWithFileName("Musics.plist")

        return music
        
    }




}
