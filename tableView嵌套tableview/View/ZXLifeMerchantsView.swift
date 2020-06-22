//
//  ZXLifeMerchantsView.swift
//  QMYY
//
//  Created by SZX on 2020/6/11.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit

    let arry : [[Int]] = [
        ///数据少的时候
//        [0,0,0]
        ///数据多的时候
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],
        [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],
        [4,4,4,4,4,4,4,4,4,4,4,4,4,4,4],
        [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5],
        [6,6,6,6,6,6,6,6,6,6,6,6,6,6,6],
        [7,7,7,7,7,7,7,7,7,7,7,7,7,7,7]
    
    ]

class ZXLifeMerchantsView: UIView {

    var tableView : UITableView!
    var canScrollBool : Bool = true
    ///设置一个让容器TableView停止滑动的高度
    ///这里295是tableViewHeadView的高度
    let specialHeight : CGFloat = 295 - STATUS_NAV_BAR_Y
    ///返回scrollView数值让导航栏渐变
    var blockScrollView:((_ scrollView : UIScrollView)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewUI()
        addOB()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeOB()
    }

}

extension ZXLifeMerchantsView{
    
    @objc func canScroll(){
        self.canScrollBool = true
    }

}

extension ZXLifeMerchantsView{
    func addOB(){
        NotificationCenter.default.addObserver(self, selector: #selector(canScroll), name: NSNotification.Name.init("LifeMerchantsCellToLifeMerchantsViewScrollNotification"), object: nil)
    }
    
    func removeOB(){
        NotificationCenter.default.removeObserver(self)
    }
}


extension ZXLifeMerchantsView : UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.blockScrollView?(scrollView)
        if scrollView.contentOffset.y >= specialHeight{
            scrollView.contentOffset = CGPoint.init(x: 0, y: specialHeight)
            if canScrollBool{
                self.canScrollBool = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LifeMerchantsViewToLifeMerchantsCellScrollNotification"), object: nil)
            }
        }
        else {
            if !self.canScrollBool{
                scrollView.contentOffset = CGPoint.init(x: 0, y: specialHeight)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.cyan
        view.frame = CGRect(x: 0, y: 0, width: SCREEN_Width, height: 38)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXLifeMerchantsCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZXLifeMerchantsCell", for: indexPath) as! ZXLifeMerchantsCell
        cell.blockBigTableViewToTop = {
            tableView.setContentOffset(CGPoint.init(x: 0, y: self.specialHeight), animated: true)
        }
        return cell
    }
}
extension ZXLifeMerchantsView{

    func tableViewUI(){
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        ///这里需要使用自定义的tableView
        tableView = ZXTableView.init(frame: rect, style: .plain)
        tableView.separatorStyle = .none
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_Width, height: 295))
        headView.backgroundColor = UIColor.red
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ZXLifeMerchantsCell.self, forCellReuseIdentifier: "ZXLifeMerchantsCell")
        self.addSubview(tableView)
    }
    
}
