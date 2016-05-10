//
//  CalculateCalendarLogic.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2016/04/27.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import Foundation

private let AD = 1 // 紀元後

/**
 *
 * カレンダーの日にちを取得してそれが祝祭日なのかを判別するための構造体
 *
 */

public enum Weekday: Int {
    case Sun, Mon, Tue, Wed, Thu, Fri, Sat

    init?(year: Int, month: Int, day: Int) {
        let cal = NSCalendar.currentCalendar()
        guard let date = cal.dateWithEra(AD, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0) else { return nil }
        let weekdayNum = cal.component(.Weekday, fromDate: date)  // 1:日曜日 ～ 7:土曜日
        self.init(rawValue: weekdayNum - 1)
    }

    var shortName: String {
        switch self {
        case .Sun: return "日"
        case .Mon: return "月"
        case .Tue: return "火"
        case .Wed: return "水"
        case .Thu: return "木"
        case .Fri: return "金"
        case .Sat: return "土"
        }
    }
    
    var mediumName: String {
        return shortName + "曜"
    }
    
    var longName: String {
        return shortName + "曜日"
    }
}

public struct CalculateCalendarLogic {
    
    private enum SpringAutumn {
        /// 春分の日
        case Spring
        
        /// 秋分の日
        case Autumn
        
        var constant: Double {
            switch self {
            case .Spring: return 20.69115
            case .Autumn: return 23.09000
            }
        }
        
        /// 春分の日・秋分の日を計算する
        /// 参考：http://koyomi8.com/reki_doc/doc_0330.htm
        func calcDay(year year: Int) -> Int {
            let x1: Double = Double(year - 2000) * 0.242194
            let x2: Int = Int(Double(year - 2000) / 4)
            return Int(constant + x1 - Double(x2))
        }
    }
    
    public init() {} // FIXME: static化した後はprivateにする
    
    /**
     *
     * 祝日になる日を判定する
     * (引数) year: Int, month: Int, day: Int, weekdayIndex: Int
     * weekdayIndexはWeekdayのenumに該当する値(0...6)が入る
     * ※1. カレンダーロジックの参考：http://p-ho.net/index.php?page=2s2
     * ※2. 書き方（タプル）の参考：http://blog.kitoko552.com/entry/2015/06/17/213553
     * ※3. [Swift] 関数における引数/戻り値とタプルの関係：http://dev.classmethod.jp/smartphone/swift-function-tupsle/
     *
     */
    public func judgeJapaneseHoliday(year: Int, month: Int, day: Int) -> Bool {
        
        let cal = NSCalendar.currentCalendar()
        guard let date = cal.dateWithEra(
            AD, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0) else {
            fatalError() // FIXME: throwにしたほうがよい？
        }
        let weekdayNum = cal.component(.Weekday, fromDate: date) // 1:日曜日 ～ 7:土曜日
        
        guard let weekday = Weekday(rawValue: weekdayNum - 1) else { fatalError("weekdayIndex is invalid.") }
        
        /// 国民の祝日に関する法律（こくみんのしゅくじつにかんするほうりつ）は、
        /// 1948年（昭和23年）7月20日に公布・即日施行された日本の法律である。通称祝日法。
        /// See also: https://ja.wikipedia.org/wiki/国民の祝日に関する法律
        let PublicHolidaysLawYear = 1948
        
        switch (year, month, day, weekday) {
            
            //1月1日: 元旦
            case (_, 1, 1, _):
                return true

            //1月2日: 振替休日
            case (_, 1, 2, .Mon):
                return true
            
            //(1).1月15日(1999年まで)、(2).1月の第2月曜日(2000年から): 成人の日
            case (year, 1, 15, _) where year <= 1999:
                return true
            
            case (year, 1, 8...14, .Mon) where year >= 2000:
                return true

            //2月11日: 成人の日
            case (_, 2, 11, _):
                return true
            
            //2月12日: 振替休日
            case (_, 2, 12, .Mon):
                return true
            
            //3月20日 or 21日: 春分の日(計算値によって算出)
            case (year, 3, day, _)
                where PublicHolidaysLawYear < year && day == SpringAutumn.Spring.calcDay(year: year):
                
                return true

            //春分の日の次が月曜日: 振替休日
            case (year, 3, day, .Mon)
                where PublicHolidaysLawYear < year && day == SpringAutumn.Spring.calcDay(year: year) + 1:
                
                return true
            
            //4月29日: 1949年から1989年までは天皇誕生日、1990年から2006年まではみどりの日、2007年以降は昭和の日
            case (year, 4, 29, _) where PublicHolidaysLawYear < year:
                return true
            
            //4月30日: 振替休日
            case (year, 4, 30, .Mon) where PublicHolidaysLawYear < year:
                return true
            
            //5月3日: 1949年から憲法記念日
            case (year, 5, 3, _) where PublicHolidaysLawYear < year:
                return true

            //5月4日: (1)1988年以前は振替休日、(2).1988年から2006年まで国民の休日、2007年以降はみどりの日
            case (year, 5, 4, .Mon) where year < 1988:
                return true

            case (1988...2006, 5, 4, .Tue),
                 (1988...2006, 5, 4, .Wed),
                 (1988...2006, 5, 4, .Thu),
                 (1988...2006, 5, 4, .Fri),
                 (1988...2006, 5, 4, .Sat):
                
                return true

            case (year, 5, 4, _) where year > 2006:
                return true
            
            //5月5日: 1949年からこどもの日
            case (year, 5, 5, _) where PublicHolidaysLawYear < year:
                return true
            
            //ゴールデンウィークの振替休日
            case (_, 5, 6, _) where getGoldenWeekAlterHoliday(year, weekday: weekday):
                return true
            
            //(1).7月20日(1996年から2002年まで)、(2).7月の第3月曜日(2003年から): 海の日
            case (year, 7, 20, _) where 1995 < year && year <= 2002:
                return true
            
            //(2).7月の第3月曜日(2003年から): 海の日
            case (year, 7, 15...21, .Mon) where 2003 <= year:
                return true
            
            //8月11日: 2016年から山の日
            case (year, 8, 11, _) where year > 2015:
                return true
            
            //8月12日: 振替休日
            case (year, 8, 12, .Mon) where year > 2015:
                return true
            
            //(1).9月15日(1966年から2002年まで)、(2).9月の第3月曜日(2003年から): 敬老の日
            case (1966...2002, 9, 15, _):
                return true
            
            case (year, 9, 15...21, .Mon) where year > 2002:
                return true
            
            //9月22日 or 23日: 秋分の日(計算値によって算出)
            case (year, 9, day, _)
                where PublicHolidaysLawYear <= year && day == SpringAutumn.Autumn.calcDay(year: year):
                
                return true
            
            //秋分の日の次が月曜日: 振替休日
            case (year, 9, day, .Mon)
                where PublicHolidaysLawYear <= year && day == SpringAutumn.Autumn.calcDay(year: year) + 1:
                
                return true
            
            //シルバーウィークの振替休日である
            case (_, 9, _, _)
                where oldPeopleDay(year: year) < day
                    && day < SpringAutumn.Autumn.calcDay(year: year)
                    && getAlterHolidaySliverWeek(year: year):
                return true
            
            //(1).10月10日(1966年から1999年まで)、(2).10月の第2月曜日(2000年から): 体育の日
            case (1966...1999, 10, 10, _):
                return true
            
            case (year, 10, 8...14, .Mon) where year > 1999:
                return true
            
            //11月3日: 1948年から文化の日
            case (year, 11, 3, _) where PublicHolidaysLawYear <= year:
                return true
            
            //11月4日: 振替休日
            case (year, 11, 4, .Mon) where PublicHolidaysLawYear <= year:
                return true
            
            //11月23日: 1948年から勤労感謝の日
            case (year, 11, 23, _) where PublicHolidaysLawYear <= year:
                return true
            
            //11月24日: 振替休日
            case (year, 11, 24, .Mon) where PublicHolidaysLawYear <= year:
                return true
            
            //12月23日: 1989年から天皇誕生日
            case (year, 12, 23, _) where year > 1989:
                return true
            
            //12月24日: 振替休日
            case (year, 12, 24, .Mon) where year > 1989:
                return true
            
            //※昔の祝日はこちら
            //4月10日: 1959年だけ皇太子明仁親王の結婚の儀
            case (year, 4, 10, _) where year == 1959:
                return true

            //2月24日: 1989年だけ昭和天皇の大喪の礼
            case (1989, 2, 24, _):
                return true
            
            //11月12日: 1989年だけ昭和天皇の大喪の礼
            case (1989, 11, 12, _):
                return true
            
            //6月9日: 1993年だけ皇太子徳仁親王の結婚の儀
            case (1993, 6, 9, _):
                return true
            
            //祝祭日ではない時
            default:
                return false
        }
    }

    /**
     *
     * ゴールデンウィークの振替休日を判定する
     * 2007年以降で5/6が月・火・水(5/3 or 5/4 or 5/5が日曜日)なら5/6を祝日とする
     * See also: https://www.bengo4.com/other/1146/1288/n_1412/
     *
     */
    private func getGoldenWeekAlterHoliday(year: Int, weekday: Weekday) -> Bool {
        switch weekday {
        case .Mon, .Tue, .Wed where 2007 <= year:
            return true
        default:
            return false
        }
    }

    /**
     *
     * シルバーウィークの振替休日を判定する
     * 敬老の日の2日後が秋分の日ならば間に挟まれた期間は国民の休日とする
     *
     */
    private func getAlterHolidaySliverWeek(year year: Int) -> Bool {
        return oldPeopleDay(year: year) + 2 == SpringAutumn.Autumn.calcDay(year: year)
    }
    
    /**
     * 指定した年の敬老の日を調べる
     */
    internal func oldPeopleDay(year year: Int) -> Int {
        let cal = NSCalendar.currentCalendar()
        
        func dateFromDay(day day: Int) -> NSDate? {
            return cal.dateWithEra(AD, year: year, month: 9, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0)
        }
        
        func weekdayAndDayFromDate(date date: NSDate) -> (weekday: Int, day: Int) {
            return (
                weekday: cal.component(.Weekday, fromDate: date),
                day:     cal.component(.Day, fromDate: date)
            )
        }
        
        let monday = 2
        return (15...21)
            .map(dateFromDay)
            .flatMap{ $0 }
            .map(weekdayAndDayFromDate)
            .filter{ $0.weekday == monday }
            .first!
            .day
    }
}
