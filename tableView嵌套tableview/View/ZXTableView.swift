//
//  ZXTableView.swift
//  QMYY
//
//  Created by SZX on 2020/6/11.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit
///UIApplication.shared.statusBarFrame.size.height,iOS13时废弃
let StatusBarHeight = returnStatusHeight()
let SCREEN_Width = UIScreen.main.bounds.size.width
let SCREEN_Height = UIScreen.main.bounds.size.height
let IS_IPHONE_X = (StatusBarHeight > 20.0)
let STATUS_NAV_BAR_Y:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0

func returnStatusHeight() -> CGFloat{
    
    var statusHeight : CGFloat = 0
    
    if #available(iOS 13.0, *){
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        statusHeight = CGFloat(statusBarManager?.statusBarFrame.size.height ?? 0)
    }
    else {
        statusHeight = UIApplication.shared.statusBarFrame.size.height
    }
    
    return statusHeight
}


class ZXTableView: UITableView {
    
}


extension ZXTableView : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}
