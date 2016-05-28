# handMadeCalendarAdvance
[ING]Swift版の日本の祝祭日判定コードとカレンダーサンプル（iOS Sample Study: Swift）

日本の祝祭日の判定ロジックとそのロジックを活用したカレンダーサンプルの例になります。
（※ 計算ロジックの実態部分はCalculateCalendarLogic.swiftを参照）

### 概要

日本の祝祭日(振替休日)を判定する構造体を作成しました。
使い方に関してはCalculateCalendarLogic.swiftをお使いのプロジェクトにコピーし、下記の「使い方」を参考に記述をして頂くとご利用になれます。
その他のカレンダーアプリやお使いのアプリでのご活用して頂ければ幸いです。

### このライブラリの内部仕様について

下記のようにjudgeJapaneseHolidayメソッドに年・月・日を引数として渡すことでその日が祝祭日(振替休日)であるかを判定します。
戻り値はBool型で返却して判定できるようにしています。

```swift
/* CalculateCalendarLogic.swift */

public func judgeJapaneseHoliday(year: Int, month: Int, day: Int) -> Bool {
    
    /**
     *
     * 祝日になる日を判定する
     * (引数) year: Int, month: Int, day: Int
     * weekdayIndexはWeekdayのenumに該当する値(0...6)が入る
     * 参考資料1. カレンダーロジックの参考                      ：http://p-ho.net/index.php?page=22
     * 参考資料2. 書き方（タプル）の参考                        ：http://blog.kitoko552.com/entry/2015/06/17/213553
     * 参考資料3. [Swift] 関数における引数/戻り値とタプルの関係 ：http://dev.classmethod.jp/smartphone/swift-function-tupsle/
     *
     */
     
     // 実装は実際のクラスを参照して頂ければ幸いです。
}
```

### 導入方法

このライブラリはCarthageに対応しています。
プロジェクト内にCartfileを作成し下記のように記述をして下さい。

`github "fumiyasac/handMadeCalendarAdvance"`

Carthageの導入やお使いのプロジェクトファイル内での設定方法につきましては下記のリンクを参考にしてみて下さい。
[Swift用依存管理マネージャのCarthageを導入する](http://edy.hatenablog.com/entry/2015/05/17/172139)

また手動でライブラリファイルを追加する方法でも使用できます。
その際は`CalculateCalendarLogic.swift`ファイルを追加して下さい。

導入例：[ライブラリを使わないカレンダーサンプル](https://github.com/fumiyasac/handMadeCalendarOfSwift)

※手動でプロジェクトに導入した際にはimport文が不要になります。

### プロジェクトでの実装例

下記のように判定したい年・月・日を引数にセットするだけでOKです。

```swift
/* ViewController.swift */

// Step1: ライブラリのインポート
import CalculateCalendarLogic

// Step2: CalculateCalendarLogicのインスタンスを作成
let holiday = CalculateCalendarLogic()
...

// Step3: 使用する際は引数を入れての判定を行う
let result: Bool = holiday.judgeJapaneseHoliday(2016, month: 1, day: 1)

// 実行結果
print("2016年1月1日：\(result)")

//コンソールでは「2016年1月1日：true」と表示されます
```

本実装ではBool型での判定ではありますが、このメソッドをカスタマイズして戻り値を変更して「祝祭日の判定＆祝祭日名を返す」ようにする等の用途に応じてのカスタマイズも可能です。

### テストケース等その他

現行プログラムでCalculateCalendarLogic.swiftで考慮したテストケースは下記の通りです。

+ 今年(2016年)の祝祭日の判定が正しく行えていること
+ ゴールデンウィークの判定が正しく行えていること(※サンプル：2017年/2019年/2021年)
+ シルバーウィークの判定が正しく行えていること(※サンプル：2015年/2026年/2032年)
+ 春分の日・秋分の日の判定が正しく行えていること(※サンプル：2000年〜2030年)

テストケースに関しては今後追加予定です。

### ライセンス
 
[MIT](https://github.com/fumiyasac/handMadeCalendarAdvance/blob/master/LICENSE)

### 更新履歴

まだまだ甘い部分があるかもしれませんが、その際はPullRequest等を送っていただければ幸いです。アプリ開発の中でこのサンプルが少しでもお役にたつ事ができれば嬉しい限りです。

+ 2016.05.28: READMEに追記をしました（Carthageで導入する際の手順や文章の修正等）
+ 2016.05.09: カレンダーに実装した例を掲載しました（UICollectionViewを使用）
+ 2016.05.01: CalculateCalendarLogic.swiftの実装と祝祭日判定テストケースを追加

