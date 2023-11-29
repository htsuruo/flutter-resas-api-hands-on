# Flutter RESAS API hands-on

内閣府地方創生推進室が提供する、地域経済分析システムの [RESAS（リーサス）](https://resas.go.jp/#/13/13101) APIを利用したFlutterハンズオン用のレポジトリです。

## スクリーンショット

| 一覧画面 | 詳細画面 |
| --- | --- |
| 市区町村一覧 | 一人あたりの地方税 |
| ![](./screenshot/list.png) | ![](./screenshot/detail.png) |

## 事前準備

プロジェクトルートに以下を記載した`env.dart`ファイルを作成してください。
このAPIキーは今回はアプリに含めてますが、実際には要件に応じてサーバーサイドに隠蔽することも検討してください。

```dart
abstract class Env {
  static const resasApiKey = '[YOUR_API_KEY]';
}

```

## Chapter

1. Widgetを使ったレイアウトの構築
    - 市区町村一覧画面のレイアウト構築
1. Navigator APIを使った画面遷移
    - 市区町村詳細画面のファイルを作成
    - Navigatorで一覧と詳細画面を行き来する
      - [Navigation and routing](https://docs.flutter.dev/ui/navigation)
    - 市区町村詳細画面のレイアウト構築
1. パッケージを利用した日本語ローカライズ
    - pubspec.yamlの使い方を学ぶ
    - `intl`と`flutter_localization`を利用する
    - [Setting up an internation­alized app](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#setting-up)
1. [enum](https://dart.dev/language/enums)を使って市区町村の種類を列挙
1. Cityクラスを作成しデータモデルを作成
    - 市区町村データとして構造化する
    - ref. [Classes | Dart](https://dart.dev/language/classes)
1. [Postman](https://www.postman.com/)を使ってAPIを叩いてみる
    - Postmanの使い方を簡単に紹介
    - RESAS APIの色々なエンドポイントを叩いてデータ取得を試す
1. APIを叩いて非同期のデータ取得
    - 非同期とは: Future/Stream、async/await
      - ref. [Asynchronous programming: futures, async, await | Dart](https://dart.dev/codelabs/async-await)
    - Jsonのパース、httpパッケージ経由でのリクエスト
    - ref. [JSON and serialization | Flutter](https://docs.flutter.dev/data-and-backend/serialization/json)
1. [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)を使って非同期で取得したデータの表示
1. (Optional) ファイル分割などリファクタリング

## 参考

- [ポケモンから学ぶFlutter](https://zenn.dev/sugitlab/books/flutter_poke_app_handson)
