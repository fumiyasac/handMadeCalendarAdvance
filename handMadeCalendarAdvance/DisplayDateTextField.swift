//
//  DisplayDateTextField.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2020/12/06.
//  Copyright © 2020 just1factory. All rights reserved.
//

import UIKit

class DisplayDateTextField: UITextField {

    // 入力カーソル表示をしない形にする
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

    // 範囲選択のカーソルを非表示にする
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }

    // 長押しして表示されるメニューを非表示にする
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
