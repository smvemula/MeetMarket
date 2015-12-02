//
//  UIColorExtension.swift
//  PlayNFLBetting
//
//  Created by Vemula, Manoj (Contractor) on 4/10/15.
//  Copyright (c) 2015 Vemula, Manoj (Contractor). All rights reserved.
//

import Foundation
import UIKit
extension UIColor
{
    public class func colorWithHexString (hex:String, andAlpha:CGFloat) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            let index1 = cString.startIndex.advancedBy(1)
            cString = cString.substringFromIndex(index1)
            //cString = cString.substringFromIndex(1)
        }
        
        if cString.utf16.count != 6 {
            return UIColor.grayColor()
        }
        
        //var rString = cString.substringToIndex(2)
        let rString = cString.substringToIndex(cString.startIndex.advancedBy(2))
        
        //var gString = cString.substringFromIndex(2).substringToIndex(2)
        let gString = cString.substringFromIndex(cString.startIndex.advancedBy(2)).substringToIndex(cString.startIndex.advancedBy(2))
        
        //var bString = cString.substringFromIndex(4).substringToIndex(2)
        let bString = cString.substringFromIndex(cString.startIndex.advancedBy(4)).substringToIndex(cString.startIndex.advancedBy(2))
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        NSScanner(string:rString).scanHexInt(&r)
        NSScanner(string:gString).scanHexInt(&g)
        NSScanner(string:bString).scanHexInt(&b)
        let rDouble = Double(r) / 255.0
        let gDouble = Double(g) / 255.0
        let bDouble = Double(b) / 255.0
        
        return UIColor(red: CGFloat(rDouble), green: CGFloat(gDouble), blue: CGFloat(bDouble), alpha: andAlpha)
    }
    
    public class func colorWithByteValues(r:Int, g:Int, b:Int, a:CGFloat) -> UIColor {
        let rDouble = Double(r) / 255.0
        let gDouble = Double(g) / 255.0
        let bDouble = Double(b) / 255.0
        return UIColor(red: CGFloat(rDouble), green: CGFloat(gDouble), blue: CGFloat(bDouble), alpha: a)
    }
    
    class func colorForValue(value: Int) -> UIColor {
        switch value {
        case 0...25:
            return UIColor.mygreenColor
        case 26...50:
            return UIColor.myblueColor
        case 51...75:
            return UIColor.myyellowColor
        default:
            return UIColor.myredColor
        }
    }
    
    class var mygreenColor : UIColor {
        return UIColor.colorWithHexString("#94c14c", andAlpha: 1)
    }
    
    class var myredColor : UIColor {
        return UIColor.colorWithHexString("#e35c53", andAlpha: 1)
    }
    
    class var myyellowColor : UIColor {
        return UIColor.colorWithHexString("#efab48", andAlpha: 1)
    }
    
    class var myblueColor : UIColor {
        return UIColor.colorWithHexString("#24aad3", andAlpha: 1)
    }
    
}