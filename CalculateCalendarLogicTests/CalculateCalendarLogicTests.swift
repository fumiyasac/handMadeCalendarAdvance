//
//  CalculateCalendarLogicTests.swift
//  CalculateCalendarLogicTests
//
//  Created by akio0911 on 2016/05/10.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import XCTest
@testable import CalculateCalendarLogic

class CalculateCalendarLogicTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     *
     * 今年(2016年)の祝祭日の判定テスト
     *
     */
    func testCurrentYear() {
        
        let test = CalculateCalendarLogic()
        
        //2016年の場合のテストケース
        let testCases: [(Int,Int,Int,Weekday,Bool)] =
            [
                // 元日: 2016年1月1日(金曜日)
                (2016,  1,  1, .Fri, true),
                
                // 成人の日: 2016年1月11日(月曜日)
                (2016,  1, 11, .Mon, true),
                
                // 建国記念の日: 2016年2月11日(木曜日)
                (2016,  2, 11, .Thu, true),
                
                // 春分の日の振替休日: 2016年3月21日(月曜日)
                (2016,  3, 21, .Mon, true),
                
                // 昭和の日: 2016年4月29日(金曜日)
                (2016,  4, 29, .Fri, true),
                
                // 憲法記念日: 2016年5月3日(火曜日)
                (2016,  5,  3, .Tue, true),
                
                // みどりの日: 2016年5月4日(水曜日)
                (2016,  5,  4, .Wed, true),
                
                // こどもの日: 2016年5月5日(木曜日)
                (2016,  5,  5, .Thu, true),
                
                // 海の日: 2016年7月18日(月曜日)
                (2016,  7, 18, .Mon, true),
                
                // 山の日: 2016年8月11日(木曜日)
                (2016,  8, 11, .Thu, true),
                
                // 敬老の日: 2016年9月19日(月曜日)
                (2016,  9, 19, .Mon, true),
                
                // 秋分の日: 2016年9月22日(木曜日)
                (2016,  9, 22, .Thu, true),
                
                // 体育の日: 2016年10月10日(月曜日)
                (2016, 10, 10, .Mon, true),
                
                // 文化の日: 2016年11月3日(木曜日)
                (2016, 11,  3, .Thu, true),
                
                // 勤労感謝の日: 2016年11月23日(水曜日)
                (2016, 11, 23, .Wed, true),
                
                //天皇誕生日: 2016年12月23日(金曜日)
                (2016, 12, 23, .Fri, true)
        ]
        testCases.forEach { year, month, day, weekday, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekday.rawValue)
            let message = "\(year)年\(month)月\(day)日（\(weekday.longName)）：\(result)"
            if expected {
                XCTAssertTrue (result, message)
            }else{
                XCTAssertFalse(result, message)
            }
        }
    }
    
    /**
     *
     * ゴールデンウィークの判定のテスト
     *
     */
    func testGoldenWeek() {
        
        let test = CalculateCalendarLogic()
        
        let testCases: [(Int,Int,Int,Weekday,Bool)] =
            [
                //  2017年
                (2017, 5, 2, .Tue, false),
                (2017, 5, 3, .Wed, true ),
                (2017, 5, 4, .Thu, true ),
                (2017, 5, 5, .Fri, true ),
                (2017, 5, 6, .Sat, false),
                
                //  2019年
                (2019, 5, 2, .Thu, false),
                (2019, 5, 3, .Fri, true ),
                (2019, 5, 4, .Sat, true ),
                (2019, 5, 5, .Sun, true ),
                (2019, 5, 6, .Mon, true ),
                
                //  2020年
                (2020, 5, 2, .Sat, false),
                (2020, 5, 3, .Sun, true ),
                (2020, 5, 4, .Mon, true ),
                (2020, 5, 5, .Tue, true ),
                (2020, 5, 6, .Wed, true ),
                (2020, 5, 7, .Thu, false),
                
                //  2021年
                (2021, 5, 2, .Sun, false),
                (2021, 5, 3, .Mon, true ),
                (2021, 5, 4, .Tue, true ),
                (2021, 5, 5, .Wed, true ),
                (2021, 5, 6, .Thu, false)
        ]
        
        testCases.forEach { year, month, day, weekday, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekday.rawValue)
            let message = "\(year)年\(month)月\(day)日（\(weekday.longName)）：\(result)"
            if expected {
                XCTAssertTrue (result, message)
            }else{
                XCTAssertFalse(result, message)
            }
        }
    }
    
    /**
     *
     * シルバーウィークの判定のテスト
     * 該当テストケース1: 2015年
     * 該当テストケース2: 2026年
     * 該当テストケース3: 2032年
     *
     */
    func testSilverWeek() {
        
        let test = CalculateCalendarLogic()
        
        let testCases: [(Int,Int,Int,Weekday,Bool)] = [
            // 2015年
            (2015, 9, 19, .Sat, false),
            (2015, 9, 20, .Sun, false),
            (2015, 9, 21, .Mon, true),
            (2015, 9, 22, .Tue, true),
            (2015, 9, 23, .Wed, true),
            (2015, 9, 24, .Thu, false),
            
            // 2016年
            (2016, 9, 19, .Mon, true),
            (2016, 9, 20, .Tue, false),
            (2016, 9, 21, .Wed, false),
            (2016, 9, 22, .Thu, true),
            (2016, 9, 23, .Fri, false),
            (2016, 9, 24, .Sat, false),
            
            // 2026年
            (2026, 9, 19, .Sat, false),
            (2026, 9, 20, .Sun, false),
            (2026, 9, 21, .Mon, true),
            (2026, 9, 22, .Tue, true),
            (2026, 9, 23, .Wed, true),
            (2026, 9, 24, .Thu, false),
            
            // 2032年
            (2032, 9, 18, .Sat, false),
            (2032, 9, 19, .Sun, false),
            (2032, 9, 20, .Mon, true),
            (2032, 9, 21, .Tue, true),
            (2032, 9, 22, .Wed, true),
            (2032, 9, 23, .Thu, false),
            ]
        testCases.forEach { year, month, day, weekday, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekday.rawValue)
            let message = "\(year)年\(month)月\(day)日（\(weekday.longName)）：\(result)"
            if expected {
                XCTAssertTrue (result, message)
            }else{
                XCTAssertFalse(result, message)
            }
        }
    }
    
    /**
     *
     * 1回目のチェックで2015/9/22が祝日であると判定できるかどうか？
     *
     */
    func testFirstJudge20160920() {
        let test = CalculateCalendarLogic()
        
        let testCases: [(Int,Int,Int,Weekday,Bool)] = [
            (2015, 9, 22, .Tue, true),
            ]
        testCases.forEach { year, month, day, weekday, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekday.rawValue)
            let message = "\(year)年\(month)月\(day)日（\(weekday.longName)）：\(result)"
            if expected {
                XCTAssertTrue (result, message)
            }else{
                XCTAssertFalse(result, message)
            }
        }
    }
    
    /**
     *
     * 春分の日・秋分の日の組み合わせが正しいかのテスト
     * 計算式算出の参考：http://koyomi8.com/reki_doc/doc_0330.htm
     * テストケース参考：http://www.nao.ac.jp/faq/a0301.html
     *
     */
    func testShunbunAndShubun() {
        
        let test = CalculateCalendarLogic()
        
        let testCases: [(Int,Int,Int,Weekday,Bool)] = [
            // 2000年
            (2000, 3, 20, .Mon, true),
            (2000, 9, 23, .Sat, true),
            
            // 2001年
            (2001, 3, 20, .Tue, true),
            (2001, 9, 23, .Sun, true),
            
            // 2002年
            (2002, 3, 21, .Thu, true),
            (2002, 9, 23, .Mon, true),
            
            // 2003年
            (2003, 3, 21, .Fri, true),
            (2003, 9, 23, .Tue, true),
            
            // 2004年
            (2004, 3, 20, .Sat, true),
            (2004, 9, 23, .Thu, true),
            
            // 2005年
            (2005, 3, 20, .Sun, true),
            (2005, 9, 23, .Fri, true),
            
            // 2006年
            (2006, 3, 21, .Tue, true),
            (2006, 9, 23, .Sat, true),
            
            // 2007年
            (2007, 3, 21, .Wed, true),
            (2007, 9, 23, .Sun, true),
            
            // 2008年
            (2008, 3, 20, .Thu, true),
            (2008, 9, 23, .Tue, true),
            
            // 2009年
            (2009, 3, 20, .Fri, true),
            (2009, 9, 23, .Wed, true),
            
            // 2010年
            (2010, 3, 21, .Sun, true),
            (2010, 9, 23, .Thu, true),
            
            // 2011年
            (2011, 3, 21, .Mon, true),
            (2011, 9, 23, .Fri, true),
            
            // 2012年
            (2012, 3, 20, .Tue, true),
            (2012, 9, 22, .Sat, true),
            
            // 2013年
            (2013, 3, 20, .Wed, true),
            (2013, 9, 23, .Mon, true),
            
            // 2014年
            (2014, 3, 21, .Fri, true),
            (2014, 9, 23, .Tue, true),
            
            // 2015年
            (2015, 3, 21, .Sat, true),
            (2015, 9, 23, .Wed, true),
            
            // 2016年
            (2016, 3, 20, .Sun, true),
            (2016, 9, 22, .Thu, true),
            
            // 2017年
            (2017, 3, 20, .Mon, true),
            (2017, 9, 23, .Sat, true),
            
            // 2018年
            (2018, 3, 21, .Wed, true),
            (2018, 9, 23, .Sun, true),
            
            // 2019年
            (2019, 3, 21, .Thu, true),
            (2019, 9, 23, .Mon, true),
            
            // 2020年
            (2020, 3, 20, .Fri, true),
            (2020, 9, 22, .Tue, true),
            
            // 2021年
            (2021, 3, 20, .Sat, true),
            (2021, 9, 23, .Thu, true),
            
            // 2022年
            (2022, 3, 21, .Mon, true),
            (2022, 9, 23, .Fri, true),
            
            // 2023年
            (2023, 3, 21, .Tue, true),
            (2023, 9, 23, .Sat, true),
            
            // 2024年
            (2024, 3, 20, .Wed, true),
            (2024, 9, 22, .Sun, true),
            
            // 2025年
            (2025, 3, 20, .Thu, true),
            (2025, 9, 23, .Tue, true),
            
            // 2026年
            (2026, 3, 20, .Fri, true),
            (2026, 9, 23, .Wed, true),
            
            // 2027年
            (2027, 3, 21, .Sun, true),
            (2027, 9, 23, .Thu, true),
            
            // 2028年
            (2028, 3, 20, .Mon, true),
            (2028, 9, 22, .Fri, true),
            
            // 2029年
            (2029, 3, 20, .Tue, true),
            (2029, 9, 23, .Sun, true),
            
            // 2030年
            (2030, 3, 20, .Wed, true),
            (2030, 9, 23, .Mon, true)
        ]
        testCases.forEach { year, month, day, weekday, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day, weekdayIndex: weekday.rawValue)
            let message = "\(year)年\(month)月\(day)日（\(weekday.longName)）：\(result)"
            if expected {
                XCTAssertTrue (result, message)
            }else{
                XCTAssertFalse(result, message)
            }
        }
    }
    
    func testOldPeopleDay() {
        let testCases: [(year: Int, expectedDay: Int)] = [
            (2005, 19),
            (2006, 18),
            (2007, 17),
            (2008, 15),
            (2009, 21),
            (2010, 20),
            (2011, 19),
            (2012, 17),
            (2013, 16),
            (2014, 15),
            (2015, 21),
            (2016, 19),
            (2017, 18),
            (2018, 17),
            (2019, 16),
            (2020, 21),
            ]
        
        testCases.forEach { year, expectedDay in
            // プロパティを確実に初期状態に戻してテストするため、このタイミングで毎回インスタンス化する
            let test = CalculateCalendarLogic()
            
            let result = test.oldPeopleDay(year: year)
            let message = "\(year)年：\(result)日"
            XCTAssertEqual(result, expectedDay, message)
        }
    }
}

