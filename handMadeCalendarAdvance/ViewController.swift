//
//  ViewController.swift
//  handMadeCalendarAdvance
//
//  Created by 酒井文也 on 2016/04/23.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

struct PageSetting {

    //UIPageViewControllerに追加するViewControllerを生成する
    static func generateCalendarController() -> UIViewController {

        //カレンダーのViewControllerクラスをStoryboardIDから取得
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Calendar")
    }

}

class ViewController: UIViewController {

    //ページ管理用のコントローラー
    var pageViewController : UIPageViewController!

    //ラベルに表示するための年と月の変数
    var targetYear: Int = 0
    var targetMonth: Int = 0

    //Outlet接続をしたUI部品の一覧
    @IBOutlet weak var prevMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //カレンダーの現在の月を表示
        getCurrentMonth()

        //UIPageViewControllerインスタンスの初期化と設定
        pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)

        //UIPageViewControllerDataSourceの拡張宣言
        pageViewController.dataSource = self

        //UIPageViewControllerの初期の位置を決める
        pageViewController.setViewControllers([PageSetting.generateCalendarController()], direction: .Forward, animated: false, completion: nil)

        //UIPageViewControllerを子のViewControllerとして登録
        addChildViewController(pageViewController)

        //UIPageViewControllerを配置
        view.addSubview(pageViewController.view)
    }

    //レイアウト処理が完了した際の処理
    override func viewDidLayoutSubviews() {

        //UIPageViewControllerのサイズを変更する
        //サイズの想定 →（X座標：0, Y座標：[backgroundViewの高さ], 幅：[おおもとのViewの幅], 高さ：[おおもとのViewの高さ -backgroundViewの高さ]）
        pageViewController.view.frame = CGRectMake(
            CGFloat(0),
            CGFloat(backgroundView.frame.height),
            CGFloat(view.frame.width),
            CGFloat(view.frame.height - backgroundView.frame.height)
        )
    }

    //前の月のボタンが押された際のアクション
    @IBAction func displayPrevMonth(sender: AnyObject) {

        getPrevMonth()

        pageViewController.setViewControllers([PageSetting.generateCalendarController()], direction: .Reverse, animated: true, completion: { finished in
            print("displayPrevMonth!")
        })

        //@todo: CalendarControllerで前の月のカレンダーを表示する
        let viewController = PageSetting.generateCalendarController()
    }

    //次の月のボタンが押された際のアクション
    @IBAction func displayNextMonth(sender: AnyObject) {

        getNextMonth()

        pageViewController.setViewControllers([PageSetting.generateCalendarController()], direction: .Forward, animated: true, completion: { finished in
            print("displayNextMonth!")
         })

        //@todo: CalendarControllerで前の月のカレンダーを表示する
        let viewController = PageSetting.generateCalendarController()
    }

    //現在の日本の年と月の情報を取得してラベル表示をする
    func getCurrentMonth() {

        //現在の日付を取得する
        let now = NSDate()

        //NSCalendarクラスのインスタンスを初期化する
        let currentCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!

        //現在の月を設定する
        getTargetCalendarParameters(currentCalendar, targetDate: now)
    }

    //前の日本の年と月の情報を取得してラベル表示をする
    func getPrevMonth() {

        //現在の月に対して-1をする
        if (targetMonth == 0) {

            targetYear = targetYear - 1
            targetMonth = 12

        } else {

            targetMonth = targetMonth - 1
        }

        //NSCalendarクラスのインスタンスから次の月の日付の情報を取得する
        let prevCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let prevComps: NSDateComponents = NSDateComponents()

        prevComps.year  = targetYear
        prevComps.month = targetMonth

        let prevDate: NSDate = prevCalendar.dateFromComponents(prevComps)!

        //表示しているカレンダーの前の月を設定する
        getTargetCalendarParameters(prevCalendar, targetDate: prevDate)
    }

    //次の日本の年と月の情報を取得してラベル表示をする
    func getNextMonth() {

        //現在の月に対して+1をする
        if (targetMonth == 12) {

            targetYear = targetYear + 1
            targetMonth = 1

        } else {

            targetMonth = targetMonth + 1
        }

        //NSCalendarクラスのインスタンスから次の月の日付の情報を取得する
        let nextCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let nextComps: NSDateComponents = NSDateComponents()

        nextComps.year  = targetYear
        nextComps.month = targetMonth

        let nextDate: NSDate = nextCalendar.dateFromComponents(nextComps)!

        //表示しているカレンダーの次の月を設定する
        getTargetCalendarParameters(nextCalendar, targetDate: nextDate)
    }

    //表示対象のカレンダーを設定する関数
    func getTargetCalendarParameters(targetCalendar: NSCalendar, targetDate: NSDate) {

        //引数で渡されたNSCalendarクラスのインスタンスとNSDateクラスのインスタンスをもとに日付の情報を取得する
        let comps = targetCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month],fromDate: targetDate)

        //年と月をInt型で取得
        targetYear  = Int(comps.year)
        targetMonth = Int(comps.month)

        //表示しているカレンダーの年と月を再度セットする
        currentMonthLabel.text = "\(targetYear)年\(targetMonth)月"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UIPageViewController dataSource

extension ViewController: UIPageViewControllerDataSource {

    //ページを前にめくった際に実行される処理
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        getPrevMonth()

        let viewController = PageSetting.generateCalendarController()

        //@todo: CalendarControllerで前の月のカレンダーを表示する

        return viewController
    }

    //ページを次にめくった際に実行される処理
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        getNextMonth()

        let viewController = PageSetting.generateCalendarController()

        //@todo: CalendarControllerで次の月のカレンダーを表示する

        return viewController
    }

}

