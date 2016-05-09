# handMadeCalendarAdvance
[ING]Swift版の日本の祝祭日判定コードとカレンダーサンプル（iOS Sample Study: Swift）

日本の祝祭日の判定ロジックとそのロジックを活用したカレンダーサンプルの例になります。
（※ 計算ロジックの実態部分はCalculateCalendarLogic.swiftを参照）

### 概要

日本の祝祭日(振替休日)を判定する構造体を作成しました。
使い方に関してはCalculateCalendarLogic.swiftをお使いのプロジェクトにコピーし、下記の「使い方」を参考に記述をして頂くとご利用になれます。
その他のカレンダーアプリやお使いのアプリでのご活用して頂ければ幸いです。

### 使い方

下記のようにjudgeJapaneseHolidayメソッドに年・月・日・曜日を引数として渡すことでその日が祝祭日(振替休日)であるかと判定します。
戻り値はBool型で返却して判定できるようにしています。

```
/* CalculateCalendarLogic.swift */
mutating func judgeJapaneseHoliday(year: Int, month: Int, day: Int, weekdayIndex: Int) -> Bool {

    //このメソッド内では年・月・日・曜日を引数にとり、calculateJapaneseHolidayメソッドで祝祭日の判定をしています。
    //※ゴールデンウィークの振替休日とシルバーウィークの国民の休日についてはこのメソッド内で判断する
    //曜日の定義については(0:日曜日, 1:月曜日, 2:火曜日, 3:水曜日, 4:木曜日, 5:金曜日, 6:金曜日)としています。
    //※曜日の定義についてはこのファイル内のenum参照
}

/* ViewController.swift */
//structのインスタンスを作成
var holiday = CalculateCalendarLogic()

...

//使用する際は引数を入れての判定を行う
let a: Bool = test.judgeJapaneseHoliday(2016, month: 1, day: 1, weekdayIndex: Weekday.Fri.rawValue)
print("2016年1月1日（金曜日）：\(a)") ==> 2016年1月1日（金曜日）：true
```

本実装ではBool型での判定にもなりますが、このメソッドをカスタマイズして戻り値を変更して「祝祭日の判定＆祝祭日名を返す」ようにする等の用途に応じてのカスタマイズも可能です。

### テストケース等その他

現行プログラムでCalculateCalendarLogic.swiftで考慮したテストケースは下記の通りです。

+ 今年(2016年)の祝祭日の判定が正しく行えていること
+ ゴールデンウィークの判定が正しく行えていること(※サンプル：2017年/2019年/2021年)
+ シルバーウィークの判定が正しく行えていること(※サンプル：2015年/2026年/2032年)
+ 春分の日・秋分の日の判定が正しく行えていること(※サンプル：2000年〜2030年)

テストケースに関しては今後追加予定。

### ライセンス
 
[MIT](https://github.com/fumiyasac/handMadeCalendarAdvance/blob/master/LICENSE)

### 更新履歴

まだまだ甘い部分があるかもしれませんが、その際はPullRequest等を送っていただければ幸いです。アプリ開発の中でこのサンプルが少しでもお役にたつ事ができれば嬉しい限りです。

+ 2016.05.09: カレンダーに実装した例を掲載しました（UICollectionViewを使用）
+ 2016.05.01: CalculateCalendarLogic.swiftの実装と祝祭日判定テストケースを追加

