//
//  KeepExtensions.swift
//  gotokeep
//
//  Created by Gaowz on 2018/11/24.
//  Copyright © 2018 fadaixiaohai. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
    }
}


extension UIFont {
    class func getKeepFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Keep", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getKeep_Run(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Keep_Run", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getKeepPadalomaItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PadalomaItalic", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func getKeepDINCondensedBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "DINCondensed-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIButton {
    func getDefaultStyle(frame: CGRect) -> UIButton {
        let button = UIButton(frame: frame)
        button.layer.cornerRadius = frame.size.height/2
        button.layer.masksToBounds = true
        button.adjustsImageWhenHighlighted = false
        button.titleLabel?.font = UIFont.getKeepFont(size: 18)
        button.backgroundColor = UIColor(red:0.19, green:0.77, blue:0.55, alpha:1.00)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage.getImageFromColor(color: UIColor(red:0.19, green:0.77, blue:0.55, alpha:1.00)), for: .normal)
        
        return button
    }
    
}

extension UIImage {
    
    class func getImageFromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}





