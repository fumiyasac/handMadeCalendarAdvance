//
//  ViewController.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2016/04/23.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit
import CalculateCalendarLogic

//カレンダーに関する定数やメソッドを定義した構造体
struct CalendarSetting {

    //カレンダーのセクション数やアイテム数に関するセッティング
    static let sectionCount = 2

    static let firstSectionItemCount = 7
    static let secondSectionItemCount = 42

    //カレンダーの日付に関するセッティング
    static let weekList: [String] = ["日","月","火","水","木","金","土"]

    //カレンダーのカラー表示に関するセッティング
    static func getCalendarColor(weekdayIndex: Int, holiday: Bool) -> UIColor {

        //日曜日または祝祭日の場合の色
        if (weekdayIndex % 7 == Weekday.Sun.rawValue || holiday == true) {

            return UIColor(red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0))

        //土曜日の場合の色
        } else if (weekdayIndex % 7 == Weekday.Sat.rawValue) {

            return  UIColor(red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0))

        //平日の場合の色
        } else {

            return UIColor.darkGrayColor()
        }
        
    }
}

//カレンダー表示＆計算用の値を取得するための構造体
struct TargetDateSetting {

    static func getTargetYearAndMonthCalendar(year: Int, month: Int) -> (Int, Int) {

        /*************
         * (重要ポイント)
         * 現在月の1日のdayOfWeek(曜日の値)を使ってカレンダーの始まる位置を決めるので'yyyy年mm月1日'のデータを作成する。
         *************/

        //NSCalendarクラスのインスタンスを初期化する
        let targetCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let targetComps: NSDateComponents = NSDateComponents()

        targetComps.year  = year
        targetComps.month = month
        targetComps.day   = 1

        let targetDate: NSDate = targetCalendar.dateFromComponents(targetComps)!
        
        //引数で渡されたNSCalendarクラスのインスタンスとNSDateクラスのインスタンスをもとに日付の情報を取得する
        let range: NSRange = targetCalendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: targetDate)
        
        let comps: NSDateComponents = targetCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday],fromDate: targetDate)
        
        //指定の年月の1日時点の日付と日数を取得してタプルで返す
        return (Int(comps.weekday), Int(range.length))
    }
}

//現在日付を取得するための構造体
struct CurrentDateSetting {

    static func getCurrentYearAndMonth() -> (Int, Int) {
        
        //NSCalendarクラスのインスタンスを初期化する
        let currentCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        //引数で渡されたNSCalendarクラスのインスタンスとNSDateクラスのインスタンスをもとに日付の情報を取得する
        let comps: NSDateComponents = currentCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month],fromDate: NSDate())
        
        //年と月をタプルで返す
        return (Int(comps.year), Int(comps.month))
    }
}

class ViewController: UIViewController {

    //ラベルに表示するための年と月の変数
    var targetYear: Int!  = CurrentDateSetting.getCurrentYearAndMonth().0
    var targetMonth: Int! = CurrentDateSetting.getCurrentYearAndMonth().1

    //カレンダー用のUICollectionView
    @IBOutlet weak var calendarCollectionView: UICollectionView!

    //Outlet接続をしたUI部品の一覧
    @IBOutlet weak var prevMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!

    //該当年月の日のリスト
    var dayCellLists: [String?] = []

    //日本の祝祭日判定用のインスタンス
    var holidayObj: CalculateCalendarLogic = CalculateCalendarLogic()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cellに使われるクラスを登録
        calendarCollectionView.registerClass(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")

        //UICollectionViewDelegate,UICollectionViewDataSourceの拡張宣言
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self

        changeCalendar()
    }

    //前の月のボタンが押された際のアクション
    @IBAction func displayPrevMonth(sender: AnyObject) {

        //現在の月に対して-1をする
        if (targetMonth == 1) {

            targetYear = targetYear - 1
            targetMonth = 12

        } else {

            targetMonth = targetMonth - 1
        }
        changeCalendar()
    }

    //次の月のボタンが押された際のアクション
    @IBAction func displayNextMonth(sender: AnyObject) {

        //現在の月に対して+1をする
        if (targetMonth == 12) {

            targetYear = targetYear + 1
            targetMonth = 1

        } else {

            targetMonth = targetMonth + 1
        }
        changeCalendar()
    }

    //カレンダー表記を変更する
    private func changeCalendar() {
        updateDataSource()
        calendarCollectionView.reloadData()
        displaySelectedCalendar()
    }

    //表示対象のカレンダーの年月を表示する
    private func displaySelectedCalendar() {
        currentMonthLabel.text = "\(targetYear)年\(targetMonth)月"
    }

    //CollectionViewCellに格納する日のデータを作成する
    private func updateDataSource() {

        var day = 1
        dayCellLists = []

        for i in 0..<(CalendarSetting.secondSectionItemCount) {

            if isCellUsing(i) {
                dayCellLists.append(String(day))
                day += 1
            } else {
                dayCellLists.append(nil)
            }
        }
    }

    //セルに値が格納されるかを判定する
    private func isCellUsing(index: Int) -> Bool {

        //該当の年と月から1日の曜日と最大日数のタプルを取得する
        let targetConcern: (Int, Int) = TargetDateSetting.getTargetYearAndMonthCalendar(targetYear, month: targetMonth)

        let targetWeekdayIndex: Int = targetConcern.0
        let targetMaxDay: Int       = targetConcern.1

        //CollectionViewの該当セルインデックスに値が入るかを判定する
        if (index < targetWeekdayIndex - 1) {

            return false

        } else if (index == targetWeekdayIndex - 1 || index < targetWeekdayIndex + targetMaxDay - 1) {

            return true

        } else if (index == targetWeekdayIndex + targetMaxDay - 1 || index < CalendarSetting.secondSectionItemCount) {

            return false
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    //配置したCollectionViewのセクション数を返す
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return CalendarSetting.sectionCount
    }

    //配置したCollectionViewの各セクションのアイテム数を返す
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            return CalendarSetting.firstSectionItemCount
        case 1:
            return CalendarSetting.secondSectionItemCount
        default:
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarCell", forIndexPath: indexPath) as! CalendarCell

        switch indexPath.section {

            case 0:

                //曜日を表示する
                cell.textLabel!.text = CalendarSetting.weekList[indexPath.row]
                cell.textLabel!.textColor = CalendarSetting.getCalendarColor(indexPath.row, holiday: false)
                return cell

            case 1:

                //該当年月の日付を表示する
                let day: String? = dayCellLists[indexPath.row]

                if isCellUsing(indexPath.row) {

                    let holiday: Bool = holidayObj.judgeJapaneseHoliday(targetYear, month: targetMonth, day: Int(day!)!)

                    cell.textLabel!.textColor = CalendarSetting.getCalendarColor(indexPath.row, holiday: holiday)
                    cell.textLabel!.text = day

                } else {

                    cell.textLabel!.text = ""
                }
                return cell

            default:
                return cell
        }

    }

}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        //日付が入るセルならば処理をする
        if isCellUsing(indexPath.row) {

            let day: String? = dayCellLists[indexPath.row]
            print("\(targetYear)年\(targetMonth)月\(day!)日")
        }
    }

}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    //セルのサイズを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - CGFloat(1.0) * numberOfMargin) / CGFloat(7)
        let height: CGFloat = width * 1.0
        return CGSizeMake(width, height)
        
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
}
