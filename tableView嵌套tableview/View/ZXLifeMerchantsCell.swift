//
//  ZXLifeMerchantsCell.swift
//  QMYY
//
//  Created by SZX on 2020/6/11.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit
///除去导航栏和seationView的高度,这个cell所剩的高度,sectionView高度为38
let ZXLifeMerchantsCellHeight : CGFloat = (SCREEN_Height - 295) + (295 - STATUS_NAV_BAR_Y) - 38
class ZXLifeMerchantsCell: UITableViewCell {
    
    var leftTableView : ZXTableView!
    var rightTableView : ZXTableView!
    var canScrollBool : Bool = false
    
    
    ///right列表滑动时,联动left列表
    var isScrollDownBool : Bool = true
    ///记录滚动到哪里
    var rightLastOffsetY : CGFloat = 0
    var leftLasstOffsetY : CGFloat = 0
    
    ///因为两个tableView要联动,当点击左列表时,需要把最外层容器上移至你设置的高度,就是specialHeight,参考过美团和饿了么,都是这么做,不这么做会有bug
    var blockBigTableViewToTop:(()->Void)?
    
    ///防止数据量过少时,推上去后无法滑下来的问题
    let scrollView = UIScrollView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        scrollViewUI()
        leftTableViewUI()
        rightTableViewUI()
        addOB()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    deinit {
        removeOB()
    }
    
}

extension ZXLifeMerchantsCell{
    
    @objc func canScroll(){
        self.canScrollBool = true
    }
    
}


extension ZXLifeMerchantsCell{
    func addOB(){
        NotificationCenter.default.addObserver(self, selector: #selector(canScroll), name: NSNotification.Name.init("LifeMerchantsViewToLifeMerchantsCellScrollNotification"), object: nil)
    }
    
    func removeOB(){
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension ZXLifeMerchantsCell : UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == leftTableView{
            if canScrollBool == true{
                leftLasstOffsetY = scrollView.contentOffset.y
            }
            scrollImportantCode(scrollView,leftLasstOffsetY)
        }
        else if scrollView == rightTableView{
            self.isScrollDownBool = rightLastOffsetY < scrollView.contentOffset.y
            if canScrollBool == true{
                rightLastOffsetY = scrollView.contentOffset.y
            }
            scrollImportantCode(scrollView,rightLastOffsetY)
        }
    }
    
    
    func scrollImportantCode(_ scrollView : UIScrollView,_ lastOffsetY : CGFloat){
        if !self.canScrollBool {
            if lastOffsetY > 0{
                scrollView.contentOffset.y = lastOffsetY
            }
            else {
                scrollView.contentOffset = CGPoint.zero
            }
            
        }
        if scrollView.contentOffset.y <= 0{
            self.canScrollBool = false
            scrollView.contentOffset = CGPoint.zero
            NotificationCenter.default.post(name: Notification.Name.init("LifeMerchantsCellToLifeMerchantsViewScrollNotification"), object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if tableView == rightTableView{
            if !isScrollDownBool && tableView.isDragging{
                
                let indexPath = IndexPath.init(row: section, section: 0)
                leftTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if tableView == rightTableView{
            if isScrollDownBool && tableView.isDragging{
                let indexPath = IndexPath.init(row: section+1, section: 0)
                leftTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView{
            return 1
        }
        if tableView == rightTableView{
            return arry.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == rightTableView{
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == rightTableView{
            let label = UILabel()
            label.text = "\(section)"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = UIColor.colorWithRGB(51, g: 51, b: 51)
            label.frame = CGRect(x: 0, y: 0, width: SCREEN_Height, height: 30)
            label.backgroundColor = UIColor.yellow
            return label
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView{
            return arry.count
        }
        else if tableView == rightTableView{
            return arry[section].count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == leftTableView{
            return ZXLifeMerchantsLeftCellHeight
        }
        else if tableView == rightTableView{
            return ZXLifeMerchantsRightCellHeight
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXLifeMerchantsLeftCell.className, for: indexPath) as! ZXLifeMerchantsLeftCell
            cell.setData(indexPath.row)
            return cell
        }
        else if tableView == rightTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: ZXLifeMerchantsRightCell.className, for: indexPath) as! ZXLifeMerchantsRightCell
            cell.setData(arry[indexPath.section][indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView{
            self.blockBigTableViewToTop?()
            canScrollBool = true
            leftTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            rightTableView.scrollToRow(at: IndexPath.init(row: 0, section: indexPath.row), at: .top, animated: true)
            if indexPath.row == 0{
                ///当容器tableView推上去之后,再次点击左边列表,联动右边列表,会使无法下啦,这里挪动一下,修复这个bug
                rightTableView.setContentOffset(CGPoint.init(x: 0, y: 1), animated: true)
            }
        }
        else if tableView == rightTableView{
            
        }
    }
    
    
    
}

extension ZXLifeMerchantsCell{
    
    func scrollViewUI(){
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_Width, height: ZXLifeMerchantsCellHeight)
        scrollView.contentSize = CGSize.init(width: 0, height: ZXLifeMerchantsCellHeight)
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        self.contentView.addSubview(scrollView)
    }
    
    func leftTableViewUI(){
        let rect = CGRect(x: 0, y: 0, width: 80, height: ZXLifeMerchantsCellHeight)
        leftTableView = ZXTableView.init(frame: rect)
        leftTableView.tableFooterView = UIView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.register(ZXLifeMerchantsLeftCell.self, forCellReuseIdentifier: ZXLifeMerchantsLeftCell.className)
        ///注意这里要判断菜单列表是否有数据
        ///默认选中第一个
        leftTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        scrollView.addSubview(leftTableView)
    }
    
    func rightTableViewUI(){
        let rect = CGRect(x: leftTableView.frame.origin.x + leftTableView.frame.size.width, y: 0, width: SCREEN_Width - 80, height: ZXLifeMerchantsCellHeight)
        rightTableView = ZXTableView.init(frame: rect)
        rightTableView.tableFooterView = UIView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.register(ZXLifeMerchantsRightCell.self, forCellReuseIdentifier: ZXLifeMerchantsRightCell.className)
        scrollView.addSubview(rightTableView)
    }
    
}
