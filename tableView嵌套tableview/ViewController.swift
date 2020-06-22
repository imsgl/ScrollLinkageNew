//
//  ViewController.swift
//  tableView嵌套tableview
//
//  Created by SZX on 2020/6/12.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rightBarBtnAry = [UIBarButtonItem]()
       var rightBtnAry = [UIButton]()
       var rightBtnImgAry = ["reservationDetailMore","reservationDetailCollection","reservationDetailShare"]
       var rightBtnSelectImgAry = ["exploreMore","reservationDetailCollectionSelect","reservationDetailShareSelect"]
       var scrollView = UIScrollView()
       let leftBtn = UIButton()
       let searchBtn = UIButton()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let offset = scrollView.contentOffset.y
        if offset < STATUS_NAV_BAR_Y{
            let coloralph = offset/STATUS_NAV_BAR_Y
            let img = UIImage.from(color: UIColor.colorWithARGB(246, g: 246, b: 246, a: coloralph))
            self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)

        }
        else {
            let img = UIImage.from(color: UIColor.white)
            self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navi()
        merchantsViewUI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension ViewController{
    
    func merchantsViewUI(){
        let merchantsView = ZXLifeMerchantsView.init(frame: CGRect(x: 0, y: -STATUS_NAV_BAR_Y, width: SCREEN_Width, height: SCREEN_Height))
        merchantsView.blockScrollView = {
            [weak self] scrollView in
            self?.scrollView = scrollView
            let offset = scrollView.contentOffset.y
            
            if offset < STATUS_NAV_BAR_Y{
                let coloralph = offset/STATUS_NAV_BAR_Y
                let img = UIImage.from(color: UIColor.colorWithARGB(246, g: 246, b: 246, a: coloralph))
                self?.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
                self?.title = ""
                self?.leftBtn.isSelected = false
                for btn in (self?.rightBtnAry)!{
                    btn.isSelected = false
                }
            }
            else {
                let img = UIImage.from(color: UIColor.white)
                self?.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
                self?.leftBtn.isSelected = true
                for btn in (self?.rightBtnAry)!{
                    btn.isSelected = true
                }
            }
        }
        self.view.addSubview(merchantsView)
    }
    
    
    func navi(){
        
        self.edgesForExtendedLayout = []
        
            leftBtn.setImage(UIImage.init(named: "reservationDetailBack"), for: .normal)
            leftBtn.setImage(UIImage.init(named: "返回"), for: .selected)
            leftBtn.isSelected = false
//            leftBtn.addTarget(self, action: #selector(leftBtnAction), for: .touchUpInside)
            let leftBarBtn = UIBarButtonItem.init(customView: leftBtn)
    //        self.navigationItem.leftBarButtonItem = leftBarBtn
            
            searchBtn.frame = CGRect(x: 0, y: 0, width: 148, height: 28)
            searchBtn.setTitle("  商品名称", for: .normal)
            searchBtn.setTitleColor(UIColor.colorWithRGB(160, g: 160, b: 160), for: .normal)
            searchBtn.setImage(UIImage.init(named: "sousuo"), for: .normal)
            searchBtn.layer.cornerRadius = 14
            searchBtn.layer.masksToBounds = true
            searchBtn.backgroundColor = UIColor.colorWithRGB(232, g: 232, b: 232)
            let leftSearchBarBtn = UIBarButtonItem.init(customView: searchBtn)
            
            self.navigationItem.leftBarButtonItems = [leftBarBtn,leftSearchBarBtn]
            
            for i in 0..<3{
                let rightBtn = UIButton()
                rightBtn.setImage(UIImage.init(named: rightBtnImgAry[i]), for: .normal)
                rightBtn.setImage(UIImage.init(named: rightBtnSelectImgAry[i]), for: .selected)
                rightBtn.tag = i
//                rightBtn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
                rightBtn.isSelected = false
                self.rightBtnAry.append(rightBtn)
                let rightBarBtn = UIBarButtonItem.init(customView: rightBtn)
                self.rightBarBtnAry.append(rightBarBtn)
            }
            self.navigationItem.rightBarButtonItems = rightBarBtnAry
        }
    
}
