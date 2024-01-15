＃ 在庫

在庫管理システムに関する Flutter プロジェクト。

＃＃ はじめる

#組み立て方

VScode Lib フォルダーと pubspec.yaml ファイルを使用して実行するには、必要です。

#論理情報
1. テーブルは 2 つあります (商品マスターと商品テーブル)。
2. 商品マスターテーブルは、スキャンしたバーコード番号が商品番号であるかどうかを確認するためのものです。
3. Product テーブルはデータを保存するためのものです。
4. バーコード機能は実装されていますが、製品マスターを確認するために統合されていません。 (まだ開発中です)
5. ユーザーは製品テーブルにデータを保存できません (まだ開発中)
6. 現在、製品テーブルに保存されている 1 つのデータがメイン画面に表示されています。
7. 商品マスターテーブルと商品テーブルのCRUD操作を実装しました。
8. Bloc パターンに従って UI、ロジック、データベースを分離しようとしました。
2日後よりフルバージョンの提供が可能となります。

# inventory

A Flutter project about Inventory management system.

## Getting Started

# How to build

To run using VScode Lib Folder and pubspec.yaml file is required.

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
