//
//  handMadeCalendarAdvanceTests.swift
//  handMadeCalendarAdvanceTests
//
//  Created by 酒井文也 on 2016/04/23.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import XCTest
@testable import handMadeCalendarAdvance

class handMadeCalendarAdvanceTests: XCTestCase {
    
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

        //元日: 2016年1月1日(金曜日)
        let a: Bool = test.judgeJapaneseHoliday(2016, month: 1, day: 1, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(a, "2016年1月1日(金曜日)：\(a)")

        //成人の日: 2016年1月11日(月曜日)
        let b: Bool = test.judgeJapaneseHoliday(2016, month: 1, day: 11, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(b, "2016年1月11日(月曜日)：\(b)")

        //建国記念の日: 2016年2月11日(木曜日)
        let c: Bool = test.judgeJapaneseHoliday(2016, month: 2, day: 11, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(c, "2016年2月11日(木曜日)：\(c)")

        //春分の日の振替休日: 2016年3月21日(月曜日)
        let d: Bool = test.judgeJapaneseHoliday(2016, month: 3, day: 21, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(d, "2016年3月21日(月曜日)：\(d)")

        //昭和の日: 2016年4月29日(金曜日)
        let e: Bool = test.judgeJapaneseHoliday(2016, month: 4, day: 29, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(e, "2016年4月29日(金曜日)：\(e)")

        //憲法記念日: 2016年5月3日(火曜日)
        let f: Bool = test.judgeJapaneseHoliday(2016, month: 5, day: 3, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(f, "2016年5月3日(火曜日)：\(f)")

        //みどりの日: 2016年5月4日(水曜日)
        let g: Bool = test.judgeJapaneseHoliday(2016, month: 5, day: 4, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(g, "2016年5月4日(水曜日)：\(g)")

        //こどもの日: 2016年5月5日(木曜日)
        let h: Bool = test.judgeJapaneseHoliday(2016, month: 5, day: 5, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(h, "2016年5月5日(木曜日)：\(h)")

        //海の日: 2016年7月18日(月曜日)
        let i: Bool = test.judgeJapaneseHoliday(2016, month: 7, day: 18, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(i, "2016年7月18日(月曜日)：\(i)")

        //山の日: 2016年8月11日(木曜日)
        let j: Bool = test.judgeJapaneseHoliday(2016, month: 8, day: 11, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(j, "2016年8月11日(木曜日)：\(j)")

        //敬老の日: 2016年9月19日(月曜日)
        let k: Bool = test.judgeJapaneseHoliday(2016, month: 9, day: 19, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(k, "2016年9月19日(月曜日)：\(k)")

        //秋分の日: 2016年9月22日(木曜日)
        let l: Bool = test.judgeJapaneseHoliday(2016, month: 9, day: 22, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(l, "2016年9月22日(木曜日)：\(l)")

        //体育の日: 2016年10月10日(月曜日)
        let m: Bool = test.judgeJapaneseHoliday(2016, month: 10, day: 10, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(m, "2016年10月10日(月曜日)：\(m)")

        //文化の日: 2016年11月3日(木曜日)
        let n: Bool = test.judgeJapaneseHoliday(2016, month: 11, day: 3, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(n, "2016年11月3日(木曜日)：\(n)")

        //勤労感謝の日: 2016年11月23日(水曜日)
        let o: Bool = test.judgeJapaneseHoliday(2016, month: 11, day: 23, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(o, "2016年11月23日(水曜日)：\(o)")

        //天皇誕生日: 2016年12月23日(金曜日)
        let p: Bool = test.judgeJapaneseHoliday(2016, month: 12, day: 23, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(p, "2016年12月23日(金曜日)：\(p)")
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

        //2000年
        let a0: Bool = test.judgeJapaneseHoliday(2000, month: 3, day: 20, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(a0, "2000年3月20日（月曜日）：\(a0)")
        let a1: Bool = test.judgeJapaneseHoliday(2000, month: 9, day: 23, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(a1, "2000年9月23日（土曜日）：\(a1)")

        //2001年
        let b0: Bool = test.judgeJapaneseHoliday(2001, month: 3, day: 20, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(b0, "2001年3月20日（火曜日）：\(b0)")
        let b1: Bool = test.judgeJapaneseHoliday(2001, month: 9, day: 23, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(b1, "2001年9月23日（日曜日）：\(b1)")

        //2002年
        let c0: Bool = test.judgeJapaneseHoliday(2002, month: 3, day: 21, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(c0, "2002年3月21日（木曜日）：\(c0)")
        let c1: Bool = test.judgeJapaneseHoliday(2002, month: 9, day: 23, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(c1, "2002年9月23日（月曜日）：\(c1)")

        //2003年
        let d0: Bool = test.judgeJapaneseHoliday(2003, month: 3, day: 21, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(d0, "2003年3月21日（金曜日）：\(d0)")
        let d1: Bool = test.judgeJapaneseHoliday(2003, month: 9, day: 23, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(d1, "2003年9月23日（火曜日）：\(d1)")

        //2004年
        let e0: Bool = test.judgeJapaneseHoliday(2004, month: 3, day: 20, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(e0, "2004年3月20日（土曜日）：\(e0)")
        let e1: Bool = test.judgeJapaneseHoliday(2004, month: 9, day: 23, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(e1, "2004年9月23日（木曜日）：\(e1)")

        //2005年
        let f0: Bool = test.judgeJapaneseHoliday(2005, month: 3, day: 20, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(f0, "2005年3月20日（日曜日）：\(f0)")
        let f1: Bool = test.judgeJapaneseHoliday(2005, month: 9, day: 23, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(f1, "2005年9月23日（金曜日）：\(f1)")

        //2006年
        let g0: Bool = test.judgeJapaneseHoliday(2006, month: 3, day: 21, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(g0, "2006年3月21日（火曜日）：\(g0)")
        let g1: Bool = test.judgeJapaneseHoliday(2006, month: 9, day: 23, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(g1, "2006年9月23日（土曜日）：\(g1)")

        //2007年
        let h0: Bool = test.judgeJapaneseHoliday(2007, month: 3, day: 21, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(h0, "2007年3月21日（水曜日）：\(h0)")
        let h1: Bool = test.judgeJapaneseHoliday(2007, month: 9, day: 23, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(h1, "2007年9月23日（土曜日）：\(h1)")

        //2008年
        let i0: Bool = test.judgeJapaneseHoliday(2008, month: 3, day: 20, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(i0, "2008年3月20日（木曜日）：\(i0)")
        let i1: Bool = test.judgeJapaneseHoliday(2008, month: 9, day: 23, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(i1, "2008年9月23日（火曜日）：\(i1)")

        //2009年
        let j0: Bool = test.judgeJapaneseHoliday(2009, month: 3, day: 20, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(j0, "2009年3月20日（金曜日）：\(j0)")
        let j1: Bool = test.judgeJapaneseHoliday(2009, month: 9, day: 23, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(j1, "2009年9月23日（水曜日）：\(j1)")

        //2010年
        let k0: Bool = test.judgeJapaneseHoliday(2010, month: 3, day: 21, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(k0, "2010年3月21日（日曜日）：\(k0)")
        let k1: Bool = test.judgeJapaneseHoliday(2010, month: 9, day: 23, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(k1, "2010年9月23日（木曜日）：\(k1)")

        //2011年
        let l0: Bool = test.judgeJapaneseHoliday(2011, month: 3, day: 21, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(l0, "2011年3月21日（月曜日）：\(l0)")
        let l1: Bool = test.judgeJapaneseHoliday(2011, month: 9, day: 23, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(l1, "2011年9月23日（金曜日）：\(l1)")

        //2012年
        let m0: Bool = test.judgeJapaneseHoliday(2012, month: 3, day: 20, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(m0, "2012年3月20日（火曜日）：\(m0)")
        let m1: Bool = test.judgeJapaneseHoliday(2012, month: 9, day: 22, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(m1, "2012年9月22日（土曜日）：\(m1)")

        //2013年
        let n0: Bool = test.judgeJapaneseHoliday(2013, month: 3, day: 20, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(n0, "2013年3月20日（水曜日）：\(n0)")
        let n1: Bool = test.judgeJapaneseHoliday(2013, month: 9, day: 23, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(n1, "2013年9月23日（月曜日）：\(n1)")

        //2014年
        let o0: Bool = test.judgeJapaneseHoliday(2014, month: 3, day: 21, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(o0, "2014年3月21日（金曜日）：\(o0)")
        let o1: Bool = test.judgeJapaneseHoliday(2014, month: 9, day: 23, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(o1, "2014年9月23日（火曜日）：\(o1)")

        //2015年
        let p0: Bool = test.judgeJapaneseHoliday(2015, month: 3, day: 21, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(p0, "2015年3月21日（土曜日）：\(p0)")
        let p1: Bool = test.judgeJapaneseHoliday(2015, month: 9, day: 23, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(p1, "2015年9月23日（水曜日）：\(p1)")

        //2016年
        let q0: Bool = test.judgeJapaneseHoliday(2016, month: 3, day: 20, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(q0, "2016年3月20日（日曜日）：\(q0)")
        let q1: Bool = test.judgeJapaneseHoliday(2016, month: 9, day: 22, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(q1, "2016年9月22日（木曜日）：\(q1)")

        //2017年
        let r0: Bool = test.judgeJapaneseHoliday(2017, month: 3, day: 20, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(r0, "2017年3月20日（月曜日）：\(r0)")
        let r1: Bool = test.judgeJapaneseHoliday(2017, month: 9, day: 23, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(r1, "2017年9月23日（土曜日）：\(r1)")

        //2018年
        let s0: Bool = test.judgeJapaneseHoliday(2018, month: 3, day: 21, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(s0, "2018年3月21日（水曜日）：\(s0)")
        let s1: Bool = test.judgeJapaneseHoliday(2018, month: 9, day: 23, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(s1, "2018年9月23日（日曜日）：\(s1)")

        //2019年
        let t0: Bool = test.judgeJapaneseHoliday(2019, month: 3, day: 21, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(t0, "2019年3月21日（木曜日）：\(t0)")
        let t1: Bool = test.judgeJapaneseHoliday(2019, month: 9, day: 23, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(t1, "2019年9月23日（月曜日）：\(t1)")

        //2020年
        let u0: Bool = test.judgeJapaneseHoliday(2020, month: 3, day: 20, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(u0, "2020年3月20日（金曜日）：\(u0)")
        let u1: Bool = test.judgeJapaneseHoliday(2020, month: 9, day: 22, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(u1, "2020年9月22日（火曜日）：\(u1)")

        //2021年
        let v0: Bool = test.judgeJapaneseHoliday(2021, month: 3, day: 20, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(v0, "2021年3月20日（土曜日）：\(v0)")
        let v1: Bool = test.judgeJapaneseHoliday(2021, month: 9, day: 23, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(v1, "2021年9月23日（木曜日）：\(v1)")

        //2022年
        let w0: Bool = test.judgeJapaneseHoliday(2022, month: 3, day: 21, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(w0, "2022年3月21日（月曜日）：\(w0)")
        let w1: Bool = test.judgeJapaneseHoliday(2022, month: 9, day: 23, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(w1, "2022年9月23日（金曜日）：\(w1)")

        //2023年
        let x0: Bool = test.judgeJapaneseHoliday(2023, month: 3, day: 21, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(x0, "2023年3月21日（火曜日）：\(x0)")
        let x1: Bool = test.judgeJapaneseHoliday(2023, month: 9, day: 23, weekdayIndex: Weekday.Sat.rawValue)
        XCTAssertTrue(x1, "2023年9月23日（土曜日）：\(x1)")

        //2024年
        let y0: Bool = test.judgeJapaneseHoliday(2024, month: 3, day: 20, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(y0, "2024年3月20日（水曜日）：\(y0)")
        let y1: Bool = test.judgeJapaneseHoliday(2024, month: 9, day: 22, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(y1, "2024年9月22日（日曜日）：\(y1)")

        //2025年
        let z0: Bool = test.judgeJapaneseHoliday(2025, month: 3, day: 20, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(z0, "2025年3月20日（木曜日）：\(z0)")
        let z1: Bool = test.judgeJapaneseHoliday(2025, month: 9, day: 23, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(z1, "2025年9月23日（火曜日）：\(z1)")

        //2026年
        let a2: Bool = test.judgeJapaneseHoliday(2026, month: 3, day: 20, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(a2, "2026年3月20日（金曜日）：\(a2)")
        let a3: Bool = test.judgeJapaneseHoliday(2026, month: 9, day: 23, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(a3, "2026年9月23日（水曜日）：\(a3)")

        //2027年
        let b2: Bool = test.judgeJapaneseHoliday(2027, month: 3, day: 21, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(b2, "2027年3月21日（日曜日）：\(b2)")
        let b3: Bool = test.judgeJapaneseHoliday(2027, month: 9, day: 23, weekdayIndex: Weekday.Thu.rawValue)
        XCTAssertTrue(b3, "2027年9月23日（木曜日）：\(b3)")

        //2028年
        let c2: Bool = test.judgeJapaneseHoliday(2028, month: 3, day: 20, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(c2, "2028年3月20日（月曜日）：\(c2)")
        let c3: Bool = test.judgeJapaneseHoliday(2028, month: 9, day: 22, weekdayIndex: Weekday.Fri.rawValue)
        XCTAssertTrue(c3, "2028年9月22日（金曜日）：\(c3)")

        //2029年
        let d2: Bool = test.judgeJapaneseHoliday(2029, month: 3, day: 20, weekdayIndex: Weekday.Tue.rawValue)
        XCTAssertTrue(d2, "2029年3月20日（火曜日）：\(d2)")
        let d3: Bool = test.judgeJapaneseHoliday(2029, month: 9, day: 23, weekdayIndex: Weekday.Sun.rawValue)
        XCTAssertTrue(d3, "2029年9月23日（日曜日）：\(d3)")

        //2030年
        let e2: Bool = test.judgeJapaneseHoliday(2030, month: 3, day: 20, weekdayIndex: Weekday.Wed.rawValue)
        XCTAssertTrue(e2, "2030年3月20日（水曜日）：\(e2)")
        let e3: Bool = test.judgeJapaneseHoliday(2030, month: 9, day: 23, weekdayIndex: Weekday.Mon.rawValue)
        XCTAssertTrue(e3, "2030年9月23日（月曜日）：\(e3)")
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
