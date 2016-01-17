//
//  PlayViewController.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/8.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

import AVFoundation

class PlayViewController: UIViewController , AVAudioPlayerDelegate , UIScrollViewDelegate{

    //MARK:- 数据属性
    var music: HTFMusic?
    
    var player: AVAudioPlayer?
    
    var timer: NSTimer?
    
    var link: CADisplayLink!
    
    private var point: CGPoint? //= CGPointMake(0, 0)
    
    //MARK:- 下部View属性
    @IBOutlet weak var colorView: UIView!
   
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var colorViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var slideBtn: UIButton!
    
    @IBOutlet weak var totalTimeLable: UILabel!
    
    @IBOutlet weak var hiddenTimeLable: UILabel!
    
   
    @IBOutlet weak var playPauseBtn: UIButton!
    //MARK:- 上部View属性
    
    @IBOutlet weak var lrcLable: HTFLable!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var singerIconView: UIImageView!
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var singerNameLable: UILabel!
    
    @IBOutlet weak var scrollView: HTFLrcScrollView!
    

    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        let window = UIApplication.sharedApplication().keyWindow
        
        window?.addSubview(self.view)
        
        self.view.frame = CGRectMake(0, window!.height, window!.width, window!.height)
        
        scrollView.delegate = self
        
        scrollView.showsHorizontalScrollIndicator = false
        
    }
    //MARK:- 在ScrollView 的操作
    override func viewWillLayoutSubviews() {
       
        scrollView.contentSize = CGSizeMake(scrollView.width * 2, scrollView.height)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        
        let scale = point.x / scrollView.width
        
        containView.alpha = 1.0 - scale * 0.8
    }
    
    //MARK:-
    internal func show(){
    
        let window = UIApplication.sharedApplication().keyWindow
        window?.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            self.view.frame = window!.frame
            
            
            }) { (isFinish) -> Void in
                
                window?.userInteractionEnabled = true
               
                self.playMusic()
        }
        
    }
    
    private func playMusic(){
        
        //更改按钮的状态
        self.playPauseBtn.selected = false
        //判断是否是同一个的播放
        if  music == HTFMusicTool.playingMusic() {
            
            if !player!.playing {
                
                player?.play()
                
                
            }else{
            
                return
            }
            
        }else{
            
            if music != nil {
             HTFPlayMusicTool.stopMusicWithName(music!.filename!)
            }
        }
        
        
        //获取数据
        let needMusic = HTFMusicTool.playingMusic()
        music = needMusic
        
        //传递音乐模型获取歌词
        self.scrollView.music = self.music!
        
        //获取播放对象
        let playerNeed = HTFPlayMusicTool.playMusicWithName(self.music!.filename!)
        
        self.player = playerNeed
        
        self.player?.delegate = self
        
        singerIconView.image = UIImage(named: music!.icon!)
        
        nameLable.text = music!.name
        
        singerNameLable.text = music!.singer
        
        totalTimeLable.text = setUpTime(player!.duration)
    
        slideBtn.setTitle(setUpTime(player!.currentTime), forState: .Normal)
        
        backImageView.image = UIImage(named: music!.icon!)
        
        //添加定时器
        addTimer()
        addLink()
        
    }
    
    
    private func stopMusic(){
    
       HTFPlayMusicTool.stopMusicWithName(music!.filename!)
        
        singerIconView.image = UIImage(named: "play_cover_pic_bg")
        
        nameLable.text = nil
        
        singerNameLable.text = nil
        
        totalTimeLable.text = nil
    
        removeTimer()
        removeLink()
    }
    
    @IBAction func back(sender: UIButton) {
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.userInteractionEnabled = false
        UIView.animateWithDuration(1.0, animations: { () -> Void in
           
            self.view.frame = CGRectMake(0, window!.height, window!.width, window!.height)
           
            }) { (isFinished) -> Void in
            
                window?.userInteractionEnabled = true
                self.removeTimer()
                self.removeLink()
        }
        
    }
    
    //MARK:- 播放暂停上下一首
    @IBAction func pausePlay(sender: UIButton?) {
        
        
        if !playPauseBtn.selected {
            
            HTFPlayMusicTool.pauseMusicWithName(music!.filename!)
            //停止
            removeLink()
            removeTimer()
        }else{
            HTFPlayMusicTool.playMusicWithName(music!.filename!)
            addTimer()
            addLink()
        }
        
        playPauseBtn.selected = !playPauseBtn.selected
        
    }

    @IBAction func next(sender: UIButton?) {
        
        HTFMusicTool.nextMusic()
        playMusic()
        
    }
    
    @IBAction func previous(sender: UIButton?) {
        
        HTFMusicTool.previousMusic()
        playMusic()
        
    }
    
    //MARK:- 将时间转换成字符串
    private func setUpTime(time: NSTimeInterval) -> String{
        
        let minute = Int(time / 60)

        let second = Int(time % 60)

        let str = String(format: "%02d" + ":" + "%02d", minute,second)//"\(minute)" + ":" + "\(second)"
        
        return str
    
    }
    //MARK:- 添加定时器
    private func addTimer(){
    
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "changeData", userInfo: nil, repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode:NSRunLoopCommonModes)
        
    
    }
    
    private func removeTimer(){
    
        timer?.invalidate()
        timer = nil
    }
    //定时器调用方法
    @objc private func changeData(){
    
        //滑块的位置更改
        
        let w = CGFloat(whiteView.width - slideBtn.width) * CGFloat(player!.currentTime) / CGFloat(player!.duration)
        
        colorViewWidth.constant = w
        
        //滑块时间
        slideBtn.setTitle(setUpTime(player!.currentTime), forState: .Normal)
        
    }
    
    private func addLink(){
    
        link = CADisplayLink(target: self, selector: "updateTime")
        
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
        
    }
    private func removeLink(){
    
        link.invalidate()
        link = nil
        
    }
    
    @objc private func updateTime(){
    
        scrollView.currentTime = player?.currentTime
        
        lrcLable.currentTime = player?.currentTime
        
    }
    
    

    //MARK:- 添加手势实现拖动点击的快进快退
    @IBAction func whiteViewTap(sender: UITapGestureRecognizer) {
        
        //获取到当前的位置
        let point = sender.locationInView(sender.view)
        
        //边界判断
        var w = point.x - slideBtn.width * 0.5;
        
        if w >= (whiteView.width - slideBtn.width) {
        
            w = whiteView.width - slideBtn.width
        }
        
        if w < 0 {
        
            w = 0
        }
        
        //改变滑块的位置
        colorViewWidth.constant = w
    
        //滑块上时间
        let  currentT = (player!.duration) * Double(w) / Double(whiteView.width - slideBtn.width) as NSTimeInterval
        
        slideBtn.setTitle(setUpTime(currentT), forState: .Normal)
        
        player?.currentTime = currentT
        
    }

    @IBAction func slideBtnap(sender: UIPanGestureRecognizer) {
        
        //获取到当前的位置
        let pointC = sender.translationInView(sender.view)
        
        //滑块位置
        let changX = pointC.x - (point?.x ?? 0)
        
        colorViewWidth.constant += changX
        
        point = pointC
        
        //边界判断
        if colorViewWidth.constant < 0 {
        
            colorViewWidth.constant = 0
        }
        if colorViewWidth.constant >= whiteView.width - slideBtn.width {
        
            colorViewWidth.constant = whiteView.width - slideBtn.width - 1
            
        }
        
        //计算当前的时间
        
        let currentT = player!.duration * Double(colorViewWidth.constant / (whiteView.width - slideBtn.width))
        
        //设置slideBtn
        slideBtn.setTitle(setUpTime(currentT), forState: .Normal)
        
        hiddenTimeLable.text = setUpTime(currentT)
        //手势判断
        if sender.state == .Began {
            
            removeTimer()
            hiddenTimeLable.hidden = false
            
        }
        
        if sender.state == .Ended || sender.state == .Cancelled {
            
            player!.currentTime = currentT
            
            addTimer()
            
            point = CGPointMake(0, 0)
            
            if !player!.playing {
                
                player!.play()
                playPauseBtn.selected = false
                
            }
        
            hiddenTimeLable.hidden = true
        }
        
    }
    
    //MARK:- player 代理方法实现自动播放下一首 有中断执行的
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
       next(nil)
        
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
         pausePlay(nil)
    }
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        pausePlay(nil)
    }
    
    
    
}
