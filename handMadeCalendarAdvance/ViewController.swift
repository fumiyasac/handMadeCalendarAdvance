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
    static func getCalendarColor(_ weekdayIndex: Int, holiday: Bool) -> UIColor {

        //日曜日または祝祭日の場合の色
        if (weekdayIndex % 7 == Weekday.sun.rawValue || holiday == true) {

            return UIColor(red: CGFloat(0.831), green: CGFloat(0.349), blue: CGFloat(0.224), alpha: CGFloat(1.0))

        //土曜日の場合の色
        } else if (weekdayIndex % 7 == Weekday.sat.rawValue) {

            return  UIColor(red: CGFloat(0.400), green: CGFloat(0.471), blue: CGFloat(0.980), alpha: CGFloat(1.0))

        //平日の場合の色
        } else {

            return UIColor.darkGray
        }
        
    }
}

//カレンダー表示＆計算用の値を取得するための構造体
struct TargetDateSetting {

    static func getTargetYearAndMonthCalendar(_ year: Int, month: Int) -> (Int, Int) {

        /*************
         * (重要ポイント)
         * 現在月の1日のdayOfWeek(曜日の値)を使ってカレンダーの始まる位置を決めるので'yyyy年mm月1日'のデータを作成する。
         *************/

        //NSCalendarクラスのインスタンスを初期化する
        let targetCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var targetComps: DateComponents = DateComponents()

        targetComps.year  = year
        targetComps.month = month
        targetComps.day   = 1

        let targetDate: Date = targetCalendar.date(from: targetComps)!
        
        //引数で渡されたNSCalendarクラスのインスタンスとNSDateクラスのインスタンスをもとに日付の情報を取得する
        let range: NSRange = (targetCalendar as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: targetDate)
        
        let comps: DateComponents = (targetCalendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekday],from: targetDate)
        
        //指定の年月の1日時点の日付と日数を取得してタプルで返す
        return (Int(comps.weekday!), Int(range.length))
    }
}

//現在日付を取得するための構造体
struct CurrentDateSetting {

    static func getCurrentYearAndMonth() -> (Int, Int) {
        
        //NSCalendarクラスのインスタンスを初期化する
        let currentCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        //引数で渡されたNSCalendarクラスのインスタンスとNSDateクラスのインスタンスをもとに日付の情報を取得する
        let comps: DateComponents = (currentCalendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month],from: Date())
        
        //年と月をタプルで返す
        return (Int(comps.year!), Int(comps.month!))
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
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")

        //UICollectionViewDelegate,UICollectionViewDataSourceの拡張宣言
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self

        changeCalendar()
    }

    //前の月のボタンが押された際のアクション
    @IBAction func displayPrevMonth(_ sender: AnyObject) {

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
    @IBAction func displayNextMonth(_ sender: AnyObject) {

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
    fileprivate func changeCalendar() {
        updateDataSource()
        calendarCollectionView.reloadData()
        displaySelectedCalendar()
    }

    //表示対象のカレンダーの年月を表示する
    fileprivate func displaySelectedCalendar() {
        currentMonthLabel.text = "\(targetYear!)年\(targetMonth!)月"
    }

    //CollectionViewCellに格納する日のデータを作成する
    fileprivate func updateDataSource() {

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
    fileprivate func isCellUsing(_ index: Int) -> Bool {

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
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return CalendarSetting.sectionCount
    }

    //配置したCollectionViewの各セクションのアイテム数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            return CalendarSetting.firstSectionItemCount
        case 1:
            return CalendarSetting.secondSectionItemCount
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell

        switch (indexPath as NSIndexPath).section {

            case 0:

                //曜日を表示する
                cell.textLabel!.text = CalendarSetting.weekList[(indexPath as NSIndexPath).row]
                cell.textLabel!.textColor = CalendarSetting.getCalendarColor((indexPath as NSIndexPath).row, holiday: false)
                return cell

            case 1:

                //該当年月の日付を表示する
                let day: String? = dayCellLists[(indexPath as NSIndexPath).row]

                if isCellUsing((indexPath as NSIndexPath).row) {

                    let holiday: Bool = holidayObj.judgeJapaneseHoliday(year: targetYear, month: targetMonth, day: Int(day!)!)

                    cell.textLabel!.textColor = CalendarSetting.getCalendarColor((indexPath as NSIndexPath).row, holiday: holiday)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //日付が入るセルならば処理をする
        if isCellUsing((indexPath as NSIndexPath).row) {

            let day: String? = dayCellLists[(indexPath as NSIndexPath).row]
            print("\(targetYear)年\(targetMonth)月\(day!)日")
        }
    }

}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - CGFloat(1.0) * numberOfMargin) / CGFloat(7)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
        
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(1.0)
    }
    
}
