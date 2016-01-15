//
//  NSObject+PlistAnalysis.swift
//  QQMusicPlayer
//
//  Created by 赫腾飞 on 16/1/6.
//  Copyright © 2016年 hetefe. All rights reserved.
//

import Foundation


extension NSObject {
    
    
    
    
    class func objectWithKeyValues(keyValues:NSDictionary) -> AnyObject{
        let model = self.init()
        //存放属性的个数
        var outCount:UInt32 = 0
        //获取所有的属性
        let properties = class_copyPropertyList(self.classForCoder(), &outCount)
        //遍历属性
        for var i = 0;i < Int(outCount);i++ {
            //获取第i个属性
            let property = properties[i]
            //得到属性的名字
            let key = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            if let value = keyValues[key]{
                //为model类赋值
                model.setValue(value, forKey: key as String)
            }
        }
        return model
    }
    
    
    class func objectWithFileName(name: String) -> NSArray{
        let path = NSBundle.mainBundle().pathForResource(name, ofType: nil)
        
        let temp = NSArray(contentsOfFile: path!)
        
        let dataArr = NSMutableArray(capacity: temp!.count)
        
        for i in 0 ..< temp!.count {
        
            let dict = temp![i]
            
            var objc = self.init()
            
            objc = self.objectWithKeyValues(dict as! NSDictionary) as! NSObject
        
            dataArr.addObject(objc)
        }
        return dataArr;
        
    }
   
}