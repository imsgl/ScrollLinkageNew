//
//  UIImageExtension.swift
//  tableView嵌套tableview
//
//  Created by SZX on 2020/6/20.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

public extension UIImage {

    class func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


