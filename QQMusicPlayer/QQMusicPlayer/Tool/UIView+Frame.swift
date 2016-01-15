//
//  UIView+Frame.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/8.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import UIKit

extension UIView {
    
    public var x:CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    
    }
    public var y:CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
        get{
            return self.frame.origin.y        }
        
    }
    public var width:CGFloat {
        
        set{
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }

        
    }
    public var height:CGFloat {
        
        set{
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
        
    }
    public var size:CGSize {
        
        set{
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    public var origin:CGPoint {
        
        set{
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
        get{
            return self.frame.origin
        }

    }

    

}