//
//  CalendarCell.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2016/05/08.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {

    //配置する要素
    var textLabel: UILabel?

    //Storyboardでセルを設定した場合
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }

    //コードでセルを設定した場合
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    //セルの表示を行うメソッド
    func setCell(cellText: String, cellTextColor: UIColor) {
        textLabel?.text = cellText
        textLabel?.textColor = cellTextColor
        textLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
    }

    //UIや見た目に関連する部分の初期化用メソッド
    private func initCommon() {
        
        //UILabelを生成
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textLabel?.text = nil
        textLabel?.backgroundColor = UIColor.white
        textLabel?.textAlignment = .center
        
        //Cellに配置したい要素を追加
        contentView.addSubview(textLabel!)
    }
}
