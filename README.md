＃ 在庫

在庫管理システムに関する Flutter プロジェクト。

＃＃ はじめる

# 組み立て方

1. Masterブランチからプロジェクトをクローンする。
2. Inventory_management_flutter/android/app/src/debug/AndroidManifest.xmlに以下の行を追加する。
に以下の行を追加する： 
<uses-permission android:name="android.permission.CAMERA"/>を追加する。
3. main.dartを実行する。

# apkファイルリンク
Inventory_management_flutter/android/apk_files/inventory_app.apk

# 論理情報
1. 2つのテーブル（商品マスターと商品テーブル）があります。
2. 商品マスタテーブルは、スキャンされたバーコード番号が商品番号であるかどうかを確認するためのものです。
3. 製品テーブルは、データを格納するためのものです。
4. バーコードは数字のみを検証することができます。
5. バーコードは、製品マスターテーブルの製品番号を持つその番号を検証することができます。
6. 製品マスタテーブルに製品番号が存在する場合にのみ、ユーザーは製品テーブルにデータを格納することはできません。
7.製品がすでに製品テーブルに存在する場合、それはそうでなければ、製品を登録する更新することができます。
8. 新規商品登録の場合、ユーザーは商品を入力するだけで、商品を発行することはできません。
9. ユーザーは領収書と領収書発行を選択することができます。
10. 商品の数量がある場合、ユーザーは商品を発行することができます。
11. ユーザーは商品テーブルの商品を削除、更新、登録できます。

DeepL.com（無料版）で翻訳しました。

# inventory

A Flutter project about Inventory management system.

## Getting Started

# How to build

1. clone the project from Master branch
2. in Inventory_management_flutter/android/app/src/debug/AndroidManifest.xml 
add the following line: 
<uses-permission android:name="android.permission.CAMERA"/>
3. run the main.dart

# apk file link
Inventory_management_flutter/android/apk_files/inventory_app.apk


# Logical Information
1. There are two tables (Product master and product table).
2. Product master table is for verifying if scanned barcode number is Product number.
3. Product table is for storing data .
4. Barcode can validate only numbers.
5. Barcode can validate that numbers which has product number in product master table.
6. User can not store data to product table only if product number exist in product master table.
7. if product already exist in product table then it can be update otherwise register the product.
8. For new product registration User can only input product not issue product.
9. User can chose receipts and issue.
10. If product quantity is available then user can issue the product.
11. user can delete /update / register product in Product table.

## Product master reference table
| id | name           | number |
|----|----------------|--------|
| 1  | tab            | 12     |
| 2  | コンピュータ  | 199    |
| 3  | スマートフォン  | 200    |
| 4  | テレビ         | 566    |
| 5  | 冷蔵庫         | 309    |


## Barcode test case
| Barcode value | Code type | Comment |
|---------------|-----------|---------|
| 12            | Barcode   | 有効    |
| 199           | Barcode   | 有効    |
| 200           | Barcode   | 有効    |
| 566           | Barcode   | 有効    |
| 309           | Barcode   | 有効    |
| 1234-abc      | Barcode   | 無効    |
| 1234          | Barcode   | 無効    |
| 2345          | Qrcode    | 無効    |
