//
//  ZXBaseNavigationViewController.swift
//  QMYY
//
//  Created by SZX on 2020/5/14.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

class ZXBaseNavigationViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let res =  self.viewControllers.count <= 1 ? false : true
        return res
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            var itemImage = UIImage(named: "返回") ?? UIImage()
            itemImage = itemImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: itemImage, style: .done, target: self, action: #selector(closeViewController))
            viewController.hidesBottomBarWhenPushed = true
            viewController.view.endEditing(true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func closeViewController() {
        if let topVC = self.topViewController {
            topVC.view.endEditing(true)
            popViewController(animated: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

fileprivate extension ZXBaseNavigationViewController{
    
    
    
    
}



extension ZXBaseNavigationViewController {
    
    override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        
        return self.topViewController
//        return viewControllers.last
    }
}
