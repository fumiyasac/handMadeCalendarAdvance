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
            calendarView.locale = Locale(identifier: "ja")
            calendarView.delegate = self

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
        if holidayObject.judgeJapaneseHoliday(year: targetYear, month: targetMonth, day: targetDay) {
            return .image(UIImage(systemName: "flag.2.crossed.fill"), color: .orange, size: .medium)
        } else {
            return nil
        }
    }
}
