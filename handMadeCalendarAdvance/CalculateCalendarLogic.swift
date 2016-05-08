//
//  CalculateCalendarLogic.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2016/04/27.
//  Copyright © 2016年 just1factory. All rights reserved.
//

/**
 *
 * カレンダーの日にちを取得してそれが祝祭日なのかを判別するための構造体
 *
 */

enum Weekday: Int {
    case Sun, Mon, Tue, Wed, Thu, Fri, Sat
    
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
        return self.shortName + "曜"
    }
    
    var longName: String {
        return self.shortName + "曜日"
    }
}

struct CalculateCalendarLogic {
    
    /**
     *
     * シルバーウィーク判定用のメンバ変数
     * ・silvarDay → 敬老の日
     * ・shubunDay → 秋分の日
     *
     */
    var silvarDay: Int = 0
    var shubunDay: Int = 0
    
    /**
     *
     * 祝日になる日を判定する
     * (引数) year: Int, month: Int, day: Int, weekdayIndex: Int
     * weekdayIndexはWeekdayのenumに該当する値(0...6)が入る
     *
     */
    mutating func judgeJapaneseHoliday(year: Int, month: Int, day: Int, weekdayIndex: Int) -> Bool {
        
        let result: Bool = self.calculateJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekdayIndex)
        
        //祝祭日の判定結果
        if (result) {
            
            return true
            
        } else {
            
            //ゴールデンウィークの振替休日である
            if (month == 5 && day == 6 && self.getGoldenWeekAlterHoliday(year, weekdayIndex: weekdayIndex)) {
                
                return true
                
            //シルバーウィークの振替休日である
            } else if ((shubunDay > day && day > silvarDay) && self.getAlterHolidaySliverWeek()) {
                
                return true
            
            //平日である
            } else {
                
                return false
            }
            
        }
    }

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
    private mutating func calculateJapaneseHoliday(year: Int, month: Int, day: Int, weekdayIndex: Int) -> Bool {
        
        //受け取った祝祭日をTupleに入れる
        let targetDate: (year: Int, month: Int, day: Int, weekdayIndex: Int) = (year, month, day, weekdayIndex)
        
        switch targetDate {
            
            //1月1日: 元旦
            case (_, month, day, _) where (month == 1 && day == 1):
                return true

            //1月2日: 振替休日
            case (_, month, day, weekdayIndex) where (month == 1 && day == 2 && weekdayIndex == 1):
                return true
            
            //(1).1月15日(1999年まで)、(2).1月の第2月曜日(2000年から): 成人の日
            case (year, month, day, _) where ((year < 2000) && (month == 1) && (day == 15)):
                return true
            
            case (year, month, day, weekdayIndex) where ((year > 1999) && (month == 1) && (day >= 8 && day <= 14) && (weekdayIndex % 7 == Weekday.Mon.rawValue)):
                return true

            //2月11日: 成人の日
            case (_, month, day, _) where (month == 2 && day == 11):
                return true
            
            //2月12日: 振替休日
            case (_, month, day, weekdayIndex) where (month == 2 && day == 12 && weekdayIndex == 1):
                return true
            
            //3月20日 or 21日: 春分の日(計算値によって算出)
            case (year, month, day, weekdayIndex) where (year > 1948 && month == 3 && day == self.getSpringDay(year)):
                return true

            //春分の日の次が月曜日: 振替休日
            case (year, month, day, _) where (year > 1948 && month == 3 && day == self.getSpringDay(year) + 1 && weekdayIndex == 1):
                return true
            
            //4月29日: 1949年から1989年までは天皇誕生日、1990年から2006年まではみどりの日、2007年以降は昭和の日
            case (year, month, day, _) where (year > 1948 && month == 4 && day == 29):
                return true
            
            //4月30日: 振替休日
            case (year, month, day, weekdayIndex) where (year > 1948 && month == 4 && day == 30 && weekdayIndex == 1):
                return true
            
            //5月3日: 1949年から憲法記念日
            case (year, month, day, _) where (year > 1948 && month == 5 && day == 3):
                return true

            //5月4日: (1)1988年以前は振替休日、(2).1988年から2006年まで国民の休日、2007年以降はみどりの日
            case (year, month, day, weekdayIndex) where (year < 1988 && month == 5 && day == 4 && weekdayIndex == 1):
                return true

            case (year, month, day, weekdayIndex) where ((year > 1987 && year < 2007) && month == 5 && day == 4 && weekdayIndex > 1):
                return true

            case (year, month, day, _) where (year > 2006 && month == 5 && day == 4):
                return true
            
            //5月5日: 1949年からこどもの日
            case (year, month, day, _) where (year > 1948 && month == 5 && day == 5):
                return true
            
            //(1).7月20日(1996年から2002年まで)、(2).7月の第3月曜日(2003年から): 海の日
            case (year, month, day, _) where ((year > 1948 && year < 2002) && month == 7 && day == 20):
                return true
            
            case (year, month, day, weekdayIndex) where ((year > 2003) && (month == 7) && (day >= 15 && day <= 21) && (weekdayIndex % 7 == Weekday.Mon.rawValue)):
                return true
            
            //8月11日: 2016年から山の日
            case (year, month, day, _) where (year > 2015 && month == 8 && day == 11):
                return true
            
            //8月12日: 振替休日
            case (year, month, day, weekdayIndex) where (year > 2015 && month == 8 && day == 12 && weekdayIndex == 1):
                return true
            
            //(1).9月15日(1966年から2002年まで)、(2).9月の第3月曜日(2003年から): 敬老の日
            case (year, month, day, _) where ((year > 1965 && year < 2003) && (month == 9) && (day == 15)):
                return true
            
            case (year, month, day, weekdayIndex) where ((year > 2002) && (month == 9) && (day >= 15 && day <= 21) && (weekdayIndex % 7 == Weekday.Mon.rawValue)):
                
                //敬老の日の判定タイミングで秋分の日の日付を取得
                silvarDay = day
                shubunDay = self.getAutumnDay(year)
                return true
            
            //9月22日 or 23日: 秋分の日(計算値によって算出)
            case (year, month, day, _) where (year > 1947 && month == 9 && day == self.getAutumnDay(year)):
                return true
            
            //秋分の日の次が月曜日: 振替休日
            case (year, month, day, _) where (year > 1947 && month == 9 && day == self.getAutumnDay(year) + 1 && weekdayIndex == 1):
                return true
            
            //(1).10月10日(1966年から1999年まで)、(2).10月の第2月曜日(2000年から): 体育の日
            case (year, month, day, _) where ((year > 1965 && year < 2000) && (month == 10) && (day == 10)):
                return true
            
            case (year, month, day, weekdayIndex) where ((year > 1999) && (month == 10) && (day >= 8 && day <= 14) && (weekdayIndex % 7 == Weekday.Mon.rawValue)):
                return true
            
            //11月3日: 1948年から文化の日
            case (year, month, day, _) where (year > 1947 && month == 11 && day == 3):
                return true
            
            //11月4日: 振替休日
            case (year, month, day, weekdayIndex) where (year > 1947 && month == 11 && day == 4 && weekdayIndex == 1):
                return true
            
            //11月23日: 1948年から勤労感謝の日
            case (year, month, day, _) where (year > 1947 && month == 11 && day == 23):
                return true
            
            //11月24日: 振替休日
            case (year, month, day, weekdayIndex) where (year > 1947 && month == 11 && day == 24 && weekdayIndex == 1):
                return true
            
            //12月23日: 1989年から天皇誕生日
            case (year, month, day, _) where (year > 1989 && month == 12 && day == 23):
                return true
            
            //12月24日: 振替休日
            case (year, month, day, weekdayIndex) where (year > 1989 && month == 12 && day == 24 && weekdayIndex == 1):
                return true
            
            //※昔の祝日はこちら
            //4月10日: 1959年だけ皇太子明仁親王の結婚の儀
            case (year, month, day, _) where (year == 1959 && month == 4 && day == 10):
                return true

            //2月24日: 1989年だけ昭和天皇の大喪の礼
            case (year, month, day, _) where (year == 1989 && month == 2 && day == 24):
                return true
            
            //11月12日: 1989年だけ昭和天皇の大喪の礼
            case (year, month, day, _) where (year == 1989 && month == 11 && day == 12):
                return true
            
            //6月9日: 1993年だけ皇太子徳仁親王の結婚の儀
            case (year, month, day, _) where (year == 1993 && month == 6 && day == 9):
                return true
            
            //祝祭日ではない時
            default:
                return false
        }
        
    }

    /**
     *
     * 春分の日を判定する
     * 参考：http://koyomi8.com/reki_doc/doc_0330.htm
     *
     */
    private func getSpringDay(year: Int) -> Int {
        
        //春分の日の計算値を返却する
        let x1: Double = Double(year - 2000) * 0.242194
        let x2: Int = Int(Double(year - 2000) / 4)
        return Int(20.69115 + x1 - Double(x2))
    }
    
    /**
     *
     * ゴールデンウィークの振替休日を判定する
     * 2007年以降で5/6が月・火・水(5/3 or 5/4 or 5/5が日曜日)なら5/6を祝日とする
     * See also: https://www.bengo4.com/other/1146/1288/n_1412/
     *
     */
    private func getGoldenWeekAlterHoliday(year: Int, weekdayIndex: Int) -> Bool {
        guard let weekday = Weekday(rawValue: weekdayIndex) else {
            fatalError("weekdayIndex is invalid.")
        }
        
        switch weekday {
        case .Mon, .Tue, .Wed where 2007 <= year:
            return true
        default:
            return false
        }
    }

    /**
     *
     * 秋分の日を判定する
     * 参考：http://koyomi8.com/reki_doc/doc_0330.htm
     *
     */
    private func getAutumnDay(year: Int) -> Int {
        
        //秋分の日の計算値を返却する
        let x1: Double = Double(year - 2000) * 0.242194
        let x2: Int = Int(Double(year - 2000) / 4)
        return Int(23.09000 + x1 - Double(x2))
    }
    
    /**
     *
     * シルバーウィークの振替休日を判定する
     * 敬老の日の2日後が秋分の日ならば間に挟まれた期間は国民の休日とする
     *
     */
    private func getAlterHolidaySliverWeek() -> Bool {
        
        if (shubunDay - silvarDay == 2) {
            return true
        } else {
            return false
        }
    }
    
}
