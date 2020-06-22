//
//  ZXLifeMerchantsRightCell.swift
//  QMYY
//
//  Created by SZX on 2020/6/12.
//  Copyright © 2020 SZX. All rights reserved.
//

import UIKit
let ZXLifeMerchantsRightCellHeight : CGFloat = 115
let ZXLifeMerchantsRightCellWidht : CGFloat = SCREEN_Width - 80
class ZXLifeMerchantsRightCell: UITableViewCell {

    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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

        // Configure the view for the selected state
    }

}

extension ZXLifeMerchantsRightCell{
    
    func setData(_ content : Int){
        label.text = "\(content)"
    }
}

extension ZXLifeMerchantsRightCell{
    
    func CreateUI(){
        label.textColor = UIColor.colorWithRGB(51, g: 51, b: 51)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: ZXLifeMerchantsRightCellWidht, height: ZXLifeMerchantsRightCellHeight)
        self.contentView.addSubview(label)
    }
}
