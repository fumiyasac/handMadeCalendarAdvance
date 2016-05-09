//
//  CalculateCalendarLogicTests.swift
//  CalculateCalendarLogicTests
//
//  Created by akio0911 on 2016/05/10.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import XCTest
@testable import CalculateCalendarLogic

private let AD = 1 // 紀元後

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
        let testCases: [(Int,Int,Int,Bool)] =
            [
                // 元日: 2016年1月1日(金曜日)
                (2016,  1,  1, true),
                
                // 成人の日: 2016年1月11日(月曜日)
                (2016,  1, 11, true),
                
                // 建国記念の日: 2016年2月11日(木曜日)
                (2016,  2, 11, true),
                
                // 春分の日の振替休日: 2016年3月21日(月曜日)
                (2016,  3, 21, true),
                
                // 昭和の日: 2016年4月29日(金曜日)
                (2016,  4, 29, true),
                
                // 憲法記念日: 2016年5月3日(火曜日)
                (2016,  5,  3, true),
                
                // みどりの日: 2016年5月4日(水曜日)
                (2016,  5,  4, true),
                
                // こどもの日: 2016年5月5日(木曜日)
                (2016,  5,  5, true),
                
                // 海の日: 2016年7月18日(月曜日)
                (2016,  7, 18, true),
                
                // 山の日: 2016年8月11日(木曜日)
                (2016,  8, 11, true),
                
                // 敬老の日: 2016年9月19日(月曜日)
                (2016,  9, 19, true),
                
                // 秋分の日: 2016年9月22日(木曜日)
                (2016,  9, 22, true),
                
                // 体育の日: 2016年10月10日(月曜日)
                (2016, 10, 10, true),
                
                // 文化の日: 2016年11月3日(木曜日)
                (2016, 11,  3, true),
                
                // 勤労感謝の日: 2016年11月23日(水曜日)
                (2016, 11, 23, true),
                
                //天皇誕生日: 2016年12月23日(金曜日)
                (2016, 12, 23, true)
        ]
        testCases.forEach { year, month, day, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day)
            guard let weekday = Weekday(year: year, month: month, day: day) else { XCTFail() ; return }
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
        
        let testCases: [(Int,Int,Int,Bool)] =
            [
                //  2017年
                (2017, 5, 2, false),
                (2017, 5, 3, true ),
                (2017, 5, 4, true ),
                (2017, 5, 5, true ),
                (2017, 5, 6, false),
                
                //  2019年
                (2019, 5, 2, false),
                (2019, 5, 3, true ),
                (2019, 5, 4, true ),
                (2019, 5, 5, true ),
                (2019, 5, 6, true ),
                
                //  2020年
                (2020, 5, 2, false),
                (2020, 5, 3, true ),
                (2020, 5, 4, true ),
                (2020, 5, 5, true ),
                (2020, 5, 6, true ),
                (2020, 5, 7, false),
                
                //  2021年
                (2021, 5, 2, false),
                (2021, 5, 3, true ),
                (2021, 5, 4, true ),
                (2021, 5, 5, true ),
                (2021, 5, 6, false)
        ]
        
        testCases.forEach { year, month, day, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day)
            guard let weekday = Weekday(year: year, month: month, day: day) else { XCTFail() ; return }
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
        
        let testCases: [(Int,Int,Int,Bool)] = [
            // 2015年
            (2015, 9, 19, false),
            (2015, 9, 20, false),
            (2015, 9, 21, true),
            (2015, 9, 22, true),
            (2015, 9, 23, true),
            (2015, 9, 24, false),
            
            // 2016年
            (2016, 9, 19, true),
            (2016, 9, 20, false),
            (2016, 9, 21, false),
            (2016, 9, 22, true),
            (2016, 9, 23, false),
            (2016, 9, 24, false),
            
            // 2026年
            (2026, 9, 19, false),
            (2026, 9, 20, false),
            (2026, 9, 21, true),
            (2026, 9, 22, true),
            (2026, 9, 23, true),
            (2026, 9, 24, false),
            
            // 2032年
            (2032, 9, 18, false),
            (2032, 9, 19, false),
            (2032, 9, 20, true),
            (2032, 9, 21, true),
            (2032, 9, 22, true),
            (2032, 9, 23, false),
            ]
        testCases.forEach { year, month, day, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day)
            guard let weekday = Weekday(year: year, month: month, day: day) else { XCTFail() ; return }
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
        
        let testCases: [(Int,Int,Int,Bool)] = [
            (2015, 9, 22, true),
            ]
        testCases.forEach { year, month, day, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day)
            guard let weekday = Weekday(year: year, month: month, day: day) else { XCTFail() ; return }
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
        
        let testCases: [(Int,Int,Int,Bool)] = [
            // 2000年
            (2000, 3, 20, true),
            (2000, 9, 23, true),
            
            // 2001年
            (2001, 3, 20, true),
            (2001, 9, 23, true),
            
            // 2002年
            (2002, 3, 21, true),
            (2002, 9, 23, true),
            
            // 2003年
            (2003, 3, 21, true),
            (2003, 9, 23, true),
            
            // 2004年
            (2004, 3, 20, true),
            (2004, 9, 23, true),
            
            // 2005年
            (2005, 3, 20, true),
            (2005, 9, 23, true),
            
            // 2006年
            (2006, 3, 21, true),
            (2006, 9, 23, true),
            
            // 2007年
            (2007, 3, 21, true),
            (2007, 9, 23, true),
            
            // 2008年
            (2008, 3, 20, true),
            (2008, 9, 23, true),
            
            // 2009年
            (2009, 3, 20, true),
            (2009, 9, 23, true),
            
            // 2010年
            (2010, 3, 21, true),
            (2010, 9, 23, true),
            
            // 2011年
            (2011, 3, 21, true),
            (2011, 9, 23, true),
            
            // 2012年
            (2012, 3, 20, true),
            (2012, 9, 22, true),
            
            // 2013年
            (2013, 3, 20, true),
            (2013, 9, 23, true),
            
            // 2014年
            (2014, 3, 21, true),
            (2014, 9, 23, true),
            
            // 2015年
            (2015, 3, 21, true),
            (2015, 9, 23, true),
            
            // 2016年
            (2016, 3, 20, true),
            (2016, 9, 22, true),
            
            // 2017年
            (2017, 3, 20, true),
            (2017, 9, 23, true),
            
            // 2018年
            (2018, 3, 21, true),
            (2018, 9, 23, true),
            
            // 2019年
            (2019, 3, 21, true),
            (2019, 9, 23, true),
            
            // 2020年
            (2020, 3, 20, true),
            (2020, 9, 22, true),
            
            // 2021年
            (2021, 3, 20, true),
            (2021, 9, 23, true),
            
            // 2022年
            (2022, 3, 21, true),
            (2022, 9, 23, true),
            
            // 2023年
            (2023, 3, 21, true),
            (2023, 9, 23, true),
            
            // 2024年
            (2024, 3, 20, true),
            (2024, 9, 22, true),
            
            // 2025年
            (2025, 3, 20, true),
            (2025, 9, 23, true),
            
            // 2026年
            (2026, 3, 20, true),
            (2026, 9, 23, true),
            
            // 2027年
            (2027, 3, 21, true),
            (2027, 9, 23, true),
            
            // 2028年
            (2028, 3, 20, true),
            (2028, 9, 22, true),
            
            // 2029年
            (2029, 3, 20, true),
            (2029, 9, 23, true),
            
            // 2030年
            (2030, 3, 20, true),
            (2030, 9, 23, true)
        ]
        testCases.forEach { year, month, day, expected in
            let result = test.judgeJapaneseHoliday(year, month: month, day: day)
            guard let weekday = Weekday(year: year, month: month, day: day) else { XCTFail() ; return }
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

