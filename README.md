# flutter_classic_ui

A small Flutter plugin that provides classic-style UI widgets for demos and local use.

注意
- このパッケージを勝手に pub.dev に公開しないでください。
  - プラグインの配布は GitHub リポジトリとして行ってください（パッケージとして公開する場合は必ず所有者の許可を得てください）。

ローカルで使う（example を実行する）

1. このリポジトリをクローンまたはダウンロードします。
2. このパッケージを利用するアプリでは、pubspec.yaml に以下のように path 依存で指定します（例: example アプリでの利用）：

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_classic_ui:
    path: ../
```

3. example アプリを起動するにはワークスペースの example ディレクトリで以下を実行します。

```bash
cd example
flutter pub get
flutter run
```

example アプリ
- example/lib/main.dart にメインのデモアプリがあり、MainMenu から各 classic_ui ウィジェットのデモページへ遷移できます。

ライセンス
- このプロジェクトの LICENSE を参照してください。

補足
- example/pubspec.yaml では `publish_to: 'none'` が設定されています。これは誤って pub.dev に公開されるのを防ぐためです。
- もしパッケージを公開する場合は、公開ポリシーと所有者の許可を必ず確認してください。
