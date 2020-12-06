//
//  DatePickerCalendarViewController.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2020/12/06.
//  Copyright © 2020 just1factory. All rights reserved.
//

import UIKit
import CalculateCalendarLogic

enum DatePickerStyle: Int {
    case drumroll = 0
    case calendar = 1
}

class DatePickerCalendarViewController: UIViewController {

    // 入力用UIDataPickerのインスタンス
    private var datePicker = UIDatePicker()

    // 日本の祝祭日判定用のインスタンス
    private let holidayObj: CalculateCalendarLogic = CalculateCalendarLogic()

    // 日付を文字列に変換するためのDateFormatter
    private var stringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    // Outlet接続をしたUI部品の一覧
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var selectDateTextField: DisplayDateTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // UISegmentedControlに関する設定
        if #available(iOS 14.0, *) {
            modeSegmentedControl.isEnabled = true
        } else {
            modeSegmentedControl.isEnabled = false
        }
        modeSegmentedControl.addTarget(self, action: #selector(self.switchDatePickerStyle(sender:)), for: .valueChanged)

        // UIDatePicker表示スタイルに関する設定
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.date = Date()

        // UITextFieldでUIDatePickerと一緒に表示するUIToolBarに関する設定
        let toolbar = UIToolbar()
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "Set!", style: .done, target: self, action: #selector(self.closeDatePicker))
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44.0)
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // 日付を表示するUITextFieldに関する設定
        selectDateTextField.delegate = self
        selectDateTextField.inputView = datePicker
        selectDateTextField.inputAccessoryView = toolbar
    }

    // SegmentedControl操作でのUIDatePicker表示スタイルの変更処理
    @objc private func switchDatePickerStyle(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if #available(iOS 14.0, *) {
            switch DatePickerStyle(rawValue: index) {
            case .drumroll:
                datePicker.preferredDatePickerStyle = .wheels
            case .calendar:
                // MEMO: inline表示は表示バグがあるので不自然な形で表示されてしまう...
                // https://qiita.com/kj_trsm/items/a53b0b3f7e1bc7c06106
                datePicker.preferredDatePickerStyle = .inline
            default:
                break
            }
        }
    }

    // UITextFieldのFirstResponderの解除処理
    @objc private func closeDatePicker() {
        if selectDateTextField.isFirstResponder {
            selectDateTextField.resignFirstResponder()
        }
    }
}

// MARK: - UITextFieldDelegate

extension DatePickerCalendarViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField)  {
        modeSegmentedControl.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        modeSegmentedControl.isEnabled = true

        // 日付を文字列に変換したものをUITextFieldへ反映
        let dateString = stringDateFormatter.string(from: datePicker.date)
        selectDateTextField.text = dateString

        // 文字列から年月日の数値を取得
        let elements: [String] = dateString.components(separatedBy: "/")
        guard let year = Int(elements[0]), let month = Int(elements[1]), let day = Int(elements[2]) else {
            return
        }

        // 祝祭日ならば文字を赤色に変更する
        if holidayObj.judgeJapaneseHoliday(year: year, month: month, day: day) {
            selectDateTextField.textColor = UIColor.red
        } else {
            selectDateTextField.textColor = UIColor.black
        }
    }
}
