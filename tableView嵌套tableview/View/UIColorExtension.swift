//
//  UIColorExtension.swift
//  tableView嵌套tableview
//
//  Created by SZX on 2020/6/20.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

public extension UIColor {

    class func colorWithRGB(_ r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor {
        return self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(1))
    }
    
    class func colorWithARGB(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor {
        return self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
