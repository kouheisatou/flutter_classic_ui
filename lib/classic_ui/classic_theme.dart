import 'package:flutter/material.dart';

/// クラシック調のテーマ定義
class ClassicTheme {
  // カラーパレット
  static const Color primaryColor = Color(0xFF2E2E2E);
  static const Color backgroundColor = Color(0xFFC0C0C0);
  static const Color surfaceColor = Color(0xFFE8E8E8);
  static const Color borderColor = Color(0xFF808080);
  static const Color shadowColor = Color(0xFF404040);
  static const Color textColor = Color(0xFF000000);
  static const Color buttonFaceColor = Color(0xFFE0E0E0);

  // フォント設定
  static const String fontFamily = 'MS Sans Serif';
  static const double baseFontSize = 11.0;

  // ボーダー設定
  static const double borderWidth = 1.0;
  static const double raisedBorderWidth = 2.0;

  // テキストスタイル
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: baseFontSize,
    fontWeight: FontWeight.bold,
    color: textColor,
    fontFamily: 'monospace',
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: baseFontSize,
    color: textColor,
    fontFamily: 'monospace',
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: baseFontSize,
    color: textColor,
    fontFamily: 'monospace',
  );

  // スペーシング
  static const double padding = 8.0;
  static const double margin = 4.0;

  /// クラシック調の3D効果のボーダー（浮き上がって見える）
  static BoxDecoration get raisedDecoration => const BoxDecoration(
    color: buttonFaceColor,
    border: Border(
      top: BorderSide(color: Colors.white, width: raisedBorderWidth),
      left: BorderSide(color: Colors.white, width: raisedBorderWidth),
      bottom: BorderSide(color: shadowColor, width: raisedBorderWidth),
      right: BorderSide(color: shadowColor, width: raisedBorderWidth),
    ),
  );

  /// クラシック調の3D効果のボーダー（押し込まれて見える）
  static BoxDecoration get sunkenDecoration => const BoxDecoration(
    color: surfaceColor,
    border: Border(
      top: BorderSide(color: shadowColor, width: raisedBorderWidth),
      left: BorderSide(color: shadowColor, width: raisedBorderWidth),
      bottom: BorderSide(color: Colors.white, width: raisedBorderWidth),
      right: BorderSide(color: Colors.white, width: raisedBorderWidth),
    ),
  );

  static const BoxDecoration buttonDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border(
      top: BorderSide(color: Colors.white, width: borderWidth),
      left: BorderSide(color: Colors.white, width: borderWidth),
      bottom: BorderSide(color: shadowColor, width: borderWidth),
      right: BorderSide(color: shadowColor, width: borderWidth),
    ),
  );

  /// フラットなボーダー
  static BoxDecoration get flatDecoration => BoxDecoration(
    color: surfaceColor,
    border: Border.all(color: borderColor, width: borderWidth),
  );

  /// クラシック���のテキストスタイル
  static TextStyle get textStyle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: baseFontSize,
    color: textColor,
  );
}
