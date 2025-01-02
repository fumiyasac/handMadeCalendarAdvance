//
//  DatePickerSelectView.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2025/01/02.
//  Copyright © 2025 just1factory. All rights reserved.
//

import CalculateCalendarLogic
import Foundation
import MijickCalendarView
import SwiftUI

// (参考) SwifUI製のライブラリとの連携サンプル
// https://medium.com/@mijick/fast-customisable-calendars-with-swiftui-e1b32446675b

struct DatePickerSelectView: View {

    // 日付を文字列に変換するためのDateFormatter
    private var stringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    // 日本の祝祭日判定用のインスタンス
    private let holidayObj: CalculateCalendarLogic = CalculateCalendarLogic()
    
    @State private var selectedDate: Date? = nil

    var body: some View {
        MCalendarView(
            selectedDate: $selectedDate,
            selectedRange: nil,
            configBuilder: configureCalendar
        )
        .onChange(of: selectedDate, perform: { newValue in
            if let newValue = newValue {
                let dateString = stringDateFormatter.string(from: newValue)
                // 文字列から年月日の数値を取得
                let elements: [String] = dateString.components(separatedBy: "/")
                guard let year = Int(elements[0]), let month = Int(elements[1]), let day = Int(elements[2]) else {
                    return
                }
                // 祝祭日かどうかを判定する
                let result = holidayObj.judgeJapaneseHoliday(year: year, month: month, day: day)
                print("選択した日付:\(dateString) 祝祭日:\(result)")
            }
        })
    }
}

extension DatePickerSelectView {
    func configureCalendar(_ config: CalendarConfig) -> CalendarConfig {
        config
            .daysHorizontalSpacing(8)
            .daysVerticalSpacing(20)
            .monthsBottomPadding(20)
            .monthsTopPadding(40)
    }
}

#Preview {
    DatePickerSelectView()
}
