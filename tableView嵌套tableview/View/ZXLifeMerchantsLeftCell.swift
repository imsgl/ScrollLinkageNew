//
//  ZXLifeMerchantsLeftCell.swift
//  QMYY
//
//  Created by SZX on 2020/6/12.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit
let ZXLifeMerchantsLeftCellHeight : CGFloat = 48
let ZXLifeMerchantsLeftCellWidth : CGFloat = 80
class ZXLifeMerchantsLeftCell: UITableViewCell {

    let bgButton = UIButton()
    let label = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.colorWithRGB(245, g: 245, b: 245)
        CreateUI()
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
        ///自定義cell被選中時的背景顏色
        self.selectedBackgroundView = UIView.init(frame: self.bounds)
        self.selectedBackgroundView?.backgroundColor = UIColor.white
        self.bgButton.isSelected = selected
        // Configure the view for the selected state
    }

}


extension ZXLifeMerchantsLeftCell{
    
    func setData(_ section : Int){
        label.text = "\(section)"
    }
    
    
    func CreateUI(){
    
        bgButton.setImage(UIImage.init(), for: .normal)
        bgButton.setImage(UIImage.init(), for: .selected)
        bgButton.frame = CGRect(x: 0, y: 0, width: ZXLifeMerchantsLeftCellWidth, height: ZXLifeMerchantsLeftCellHeight)
        bgButton.isUserInteractionEnabled = false
        self.contentView.addSubview(bgButton)
        
        label.textColor = UIColor.colorWithRGB(51, g: 51, b: 51)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: ZXLifeMerchantsLeftCellWidth, height: ZXLifeMerchantsLeftCellHeight)
        self.contentView.addSubview(label)
        
    }
    
}
