# handMadeCalendarAdvance(CalculateCalendarLogic)
This library CalculateCalendarLogic (sample project name is handMadeCalendarAdvance) can judge a holiday in Japan.

### Description

This library 'CalculateCalendarLogic' can judge a holiday in Japan.
When you use this library, you can judge can judge a holiday in Japan very easily.
A method which named 'judgeJapaneseHoliday' method stores variables year, month, and day in an argument, it returns true or false.

### About CalculateCalendarLogic.swift

```swift
/* CalculateCalendarLogic.swift */

public func judgeJapaneseHoliday(year: Int, month: Int, day: Int) -> Bool {

    /**
     *
     * - Description judge japanese holiday
     * - parameter year: year value (Int)
     * - parameter month: month value (Int)
     * - parameter day: day value (Int)
     * - returns: result (Bool)
     */

     // judge holiday logic...
}
```

### Requirements & Support

+ iOS 9 or later
+ macOS 10.10 or later

### Installation

We can use this library with CocoaPods, Carthage, Swift Package Manager, Manually.

##### Use CocoaPods

Create Podfile and specify it in your Podfile:

★ Example of Podfile

```
platform :ios, '9.0'
use_frameworks!
target [YOUR PROJECT NAME]' do
  pod 'CalculateCalendarLogic'
end
```

##### Use Carthage

Create Carthage and specify it in your Cartfile:

★ Cartfile

```
github "fumiyasac/handMadeCalendarAdvance"
```

##### Use Swift Package Manager

Using Xcode, go to File -> Swift Packages -> Add Package Dependency and enter URL below:
https://github.com/fumiyasac/handMadeCalendarAdvance

##### Manually

Copy all the files in CalculateCalendarLogic/CalculateCalendarLogic.swift file into your project.

### Author

fumiyasac(Fumiya Sakai)

### Example

It's as below.

```swift
/* ViewController.swift */

// Step1: import CalculateCalendarLogic (If you install manually, you don't need import statement.)
import CalculateCalendarLogic

// Step2: create instance of CalculateCalendarLogic
let holiday = CalculateCalendarLogic()
...

// Step3: input year, month and day values into judgeJapaneseHoliday method.
let result: Bool = holiday.judgeJapaneseHoliday(year: 2016, month: 1, day: 1)

// Result:
print("2016 January 1：\(result)")

//You will display「2016 January 1：true」in your Xcode console.
```

### License

[MIT](https://github.com/fumiyasac/handMadeCalendarAdvance/blob/master/LICENSE)

### Contributor

Special Thanks to

+ [akio0911](https://github.com/akio0911): Technical Support & Refactoring
+ [akuraru](https://github.com/akuraru): Refactoring & Bugfix
+ [keygx](https://github.com/keygx): How to use CocoaPods
+ [econa77](https://twitter.com/econa77): Mac OS 10.10 Support
+ [essochi](https://github.com/essochi): Ver0.1.7
+ [myammm](https://github.com/myammm): Ver0.2.0 
+ [kazuomatz](https://github.com/kazuomatz): Refactoring & Bugfix

and more iOS developers.

# handMadeCalendarAdvance(CalculateCalendarLogic)
Swift版の日本の祝祭日判定コードとカレンダーライブラリとサンプル

![サンプル表示例](https://qiita-image-store.s3.amazonaws.com/0/17400/0d6ed6b2-6dc0-6a80-a2ea-4757bea94d4b.jpeg)

日本の祝祭日の判定ロジックとそのロジックを活用したカレンダーサンプルの例になります。
（※ 計算ロジックの実態部分はCalculateCalendarLogic.swiftを参照）

### 概要

日本の祝祭日(振替休日)を判定する構造体を作成しました。
使い方に関してはCalculateCalendarLogic.swiftをお使いのプロジェクトにコピーし、下記の「使い方」を参考に記述をして頂くとご利用になれます。
その他のカレンダーアプリを作成する際やお使いのアプリでご活用して頂ければ幸いです。

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

### 対応バージョンとサポート

+ iOS 9 or later
+ macOS 10.10 or later

### 導入方法

このライブラリはCocoaPods・Carthage・Swift Package Manager及び手動での追加に対応しています。

##### CocoaPodsでの追加

プロジェクト内にPodfileを作成し下記のように記述をして下さい。

★ Podfileの記述例

```
target '[自分のプロジェクト名]' do
  use_frameworks!
  pod 'CalculateCalendarLogic'
end
```

##### Carthageでの追加

プロジェクト内にCartfileを作成し下記のように記述をして下さい。

★ Cartfileの記述

```
github "fumiyasac/handMadeCalendarAdvance"
```

参考：[Carthageを使った外部ライブラリ導入方法](http://swift.swift-studying.com/entry/2015/09/23/215356)

##### Swift Package Managerでの追加

お使いのXcodeで「File -> Swift Packages -> Add Package Dependency」と進み、後述するURLを入力してEnterキーを押下して下さい。
https://github.com/fumiyasac/handMadeCalendarAdvance

##### 手動での追加

また手動でライブラリファイルを追加する場合には、`CalculateCalendarLogic.swift`ファイルをご自身のプロジェクトに追加して下さい。

導入例：[ライブラリを使わないカレンダーサンプル](https://github.com/fumiyasac/handMadeCalendarOfSwift)

### Author

fumiyasac(Fumiya Sakai)

### プロジェクトでの実装例

下記のように判定したい年・月・日を引数にセットするだけでOKです。

```swift
/* ViewController.swift */

// Step1: ライブラリのインポート（手動で導入した場合は不要）
import CalculateCalendarLogic

// Step2: CalculateCalendarLogicのインスタンスを作成
let holiday = CalculateCalendarLogic()
...

// Step3: 使用する際は引数を入れての判定を行う
let result: Bool = holiday.judgeJapaneseHoliday(year: 2016, month: 1, day: 1)

// 実行結果
print("2016年1月1日：\(result)")

//コンソールでは「2016年1月1日：true」と表示されます
```

本実装ではBool型での判定ではありますが、このメソッドをカスタマイズして戻り値を変更して「祝祭日の判定＆祝祭日名を返す」ようにする等の用途に応じてのカスタマイズも可能です。

### テストケース等その他

現行プログラムでCalculateCalendarLogic.swiftで考慮したテストケースは下記の通りです。

+ 今年(2016年〜2022年)の祝祭日の判定が正しく行えていること
+ ゴールデンウィークの判定が正しく行えていること(※サンプル：2017年/2019年/2021年)
+ シルバーウィークの判定が正しく行えていること(※サンプル：2015年/2026年/2032年)
+ 春分の日・秋分の日の判定が正しく行えていること(※サンプル：2000年〜2030年)

テストケースに関しては今後追加予定です。

### ライセンス

[MIT](https://github.com/fumiyasac/handMadeCalendarAdvance/blob/master/LICENSE)

### 更新履歴

まだまだ甘い部分があるかもしれませんが、その際はPullRequest等を送っていただければ幸いです。アプリ開発の中でこのサンプルが少しでもお役にたつ事ができれば嬉しい限りです。

+ 2019.12.02: Xcode12.2への対応/2021年の祝日に関する追加対応/サンプルコード修正等を行いました。
+ 2019.06.26: Swift5.0及びXcode10.2.1への対応を行いました。
+ 2019.01.23: 2019年の祝日に関する追加対応を行いました（[kazuomatz](https://github.com/kazuomatz)様）。
+ 2018.12.02: Swift4.2及びXcode10への対応を行いました。
+ 2018.08.08: 2020年のカレンダーへの対応を行いました（[myammm](https://github.com/myammm)様）。
+ 2018.07.04: Swift4.1及びXCode9.4への対応を行いました（[essochi](https://github.com/essochi)様）。
+ 2017.10.10: Swift4及びXCode9への対応を行いました。
+ 2017.01.14: macOS10.10と以降バージョンへのサポートが可能になりました。
+ 2016.12.31: 最新版をCocoaPods & Carthageへの対応を行いました。
+ 2016.12.29: Swift3系への対応を行いました。
+ 2016.10.13: Swift2.3及びSwift3.0ブランチ作成
+ 2016.09.03: CocoaPodsへの対応をしました（ドキュメント修正や追記含む）
+ 2016.05.28: READMEに追記をしました（Carthageで導入する際の手順や文章の修正等）
+ 2016.05.09: カレンダーに実装した例を掲載しました（UICollectionViewを使用）
+ 2016.05.01: CalculateCalendarLogic.swiftの実装と祝祭日判定テストケースを追加

### 謝辞

このライブラリの作成にあたり[akio0911](https://github.com/akio0911)さん、[akuraru](https://github.com/akuraru)さん、[keygx](https://github.com/keygx)さん、[econa77](https://twitter.com/econa77)さん、[kazuomatz](https://github.com/kazuomatz)さんに多くのお力添えを頂きまして誠にありがとうございました。
また、プルリクエスト等を定期的に頂けることで本当に助かっております。
