//
//  NewCalendarViewController.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2023/01/01.
//  Copyright © 2023 just1factory. All rights reserved.
//

import UIKit
import CalculateCalendarLogic

class NewCalendarViewController: UIViewController {

    // 日本の祝祭日判定用のインスタンス
    private let holidayObject: CalculateCalendarLogic = CalculateCalendarLogic()

    private var stringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    private var currentCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja_JP")
        calendar.timeZone = TimeZone.current
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
    }
    
    // CalendarViewのセットアップ
    // ※現時点(Xcode14.1)ではまだStoryboardから追加できない...
    private func setupCalendarView() {
        if #available(iOS 16.0, *) {
            let calendarView = UICalendarView()
            calendarView.calendar = Calendar(identifier: .gregorian)
            calendarView.locale = Locale(identifier: "ja_JP")
            calendarView.delegate = self
            // 例. 任意の日付を1つ選択可能にする
            // 補足: 複数日付を選択する場合はこちらをする
            // https://developer.apple.com/documentation/uikit/uicalendarselectionmultidate
            let dateSelection = UICalendarSelectionSingleDate(delegate: self)
            calendarView.selectionBehavior = dateSelection
            view.addSubview(calendarView)
            calendarView.translatesAutoresizingMaskIntoConstraints = false
            calendarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            calendarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            calendarView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            calendarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            let title = "バージョンがiOS15以下です"
            let message = "iOS16以前ではCalendarViewを表示することができません。"
            let completionHandler: (() -> ())? = {
                self.navigationController?.popViewController(animated: true)
            }
            showCloseAlertWith(title: title, message: message, completionHandler: completionHandler)
        }
    }

    private func showCloseAlertWith(title: String, message: String, completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "前の画面へ戻る", style: .default, handler: { _ in
            completionHandler?()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICalendarViewDelegate

extension NewCalendarViewController: UICalendarViewDelegate {

    // CalendarViewに適用する装飾を決定する
    // 👉 このコードでは祝祭日の部分にオレンジの🏴マークを付与する
    // 参考: https://www.fuwamaki.com/article/353
    @available(iOS 16.0, *)
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let targetYear = dateComponents.year,
              let targetMonth = dateComponents.month,
              let targetDay = dateComponents.day else {
            return nil
        }

        // 注意: weekdayプロパティはUICalendarViewDelegateまで常にnilになる...
        // print("dateComponents.weekday", dateComponents.weekday)

        let weekday = getWeekDay(year: targetYear, month: targetMonth, day: targetDay)
        let isHoliday = holidayObject.judgeJapaneseHoliday(year: targetYear, month: targetMonth, day: targetDay)

        if isHoliday {
            return .image(UIImage(systemName: "flag.2.crossed.fill"), color: .orange, size: .medium)
        } else if weekday == 1 {
            return .default(color: .red, size: .small)
        } else if weekday == 7 {
            return .default(color: .blue, size: .small)
        } else {
            return nil
        }
    }

    // 年・月・日から曜日（日曜日:1 ~ 土曜日:7）を取得する
    private func getWeekDay(year: Int, month: Int, day: Int) -> Int {
        let formatString = "%04d/%02d/%02d"
        guard let date: Date = stringDateFormatter.date(from: String(format: formatString, year, month, day)) else {
            return 0
        }
        return currentCalendar.component(.weekday, from: date)
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate

extension NewCalendarViewController: UICalendarSelectionSingleDateDelegate {

    // 日付を選択したタイミングで選択した日付情報を返す
    @available(iOS 16.0, *)
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let targetDateComponents = dateComponents else {
            return
        }
        guard let targetYear = targetDateComponents.year,
            let targetMonth = targetDateComponents.month,
            let targetDay = targetDateComponents.day else {
            return
        }
        print("あなたが選択した日付:", "\(targetYear)年\(targetMonth)月\(targetDay)日")
    }

    // 日付を選択可能な状態とするかを設定する
    @available(iOS 16.0, *)
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}
