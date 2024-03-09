# Zaim-Connector
## about
各種サービスの入金・出金履歴CSVを、zaimのCSV入力に変換するためのソフトです。

## requirements
- ruby 3.3.0
## install
```
$ git clone hogehoge
$ cd zaim-connector
$ bundle install
$ ruby app.rb convert paypay 2024/02/21 2024/05/21
```

## 使い方
### 設定
入力したいCSVファイルの形式に応じて、`config/{type}.csv`を用意する必要があります。
`config/paypay.csv`は、[履歴出力 for PayPay](https://play.google.com/store/apps/details?id=app.tsumuchan.exporter&hl=ja&gl=US)から出力したCSVの設定例です。
```
description_column_index: 明細の詳細が格納されている列のインデックス
shop_name_column_index: 店名が格納されている列のインデックス
payment_amount_column_index: 利用金額が格納されている列のインデックス
time_column_index: 利用日時が格納されている列のインデックス
time_format: 利用日時のフォーマット
```

time_formatの形式は、[Time.strptime](https://docs.ruby-lang.org/ja/latest/method/Time/s/strptime.html)の形式です。

### ファイルの用意
入力したいファイルを、`datasource/{type}.csv` として配置します。


### CLI
```
$ruby app.rb convert {type} {start_at: 取り込み対象期間の開始日時（必須）} {end_at: 取り込み対象期間の終了日時（任意）}
```
end_atを指定しなかった場合、現在時刻がend_atとして扱われます。

