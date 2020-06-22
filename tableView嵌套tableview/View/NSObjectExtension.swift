//
//  NSObjectExtension.swift
//  tableView嵌套tableview
//
//  Created by SZX on 2020/6/20.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

public extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}
