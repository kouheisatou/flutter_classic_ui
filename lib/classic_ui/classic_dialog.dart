import 'package:flutter/material.dart';
import 'classic_theme.dart';
import 'classic_button.dart';

class ClassicDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  final double? width;
  final double? height;

  const ClassicDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width ?? 300,
        height: height,
        decoration: ClassicTheme.raisedDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: ClassicTheme.padding,
                vertical: ClassicTheme.padding / 2,
              ),
              decoration: const BoxDecoration(
                color: ClassicTheme.primaryColor,
                border: Border(
                  bottom: BorderSide(
                    color: ClassicTheme.borderColor,
                    width: ClassicTheme.borderWidth,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: ClassicTheme.titleTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: ClassicTheme.raisedDecoration,
                      child: const Center(
                        child: Text(
                          '×',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ClassicTheme.textColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ClassicTheme.padding),
                color: ClassicTheme.surfaceColor,
                child: content,
              ),
            ),
            // Actions
            if (actions.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ClassicTheme.padding),
                decoration: const BoxDecoration(
                  color: ClassicTheme.buttonFaceColor,
                  border: Border(
                    top: BorderSide(
                      color: ClassicTheme.borderColor,
                      width: ClassicTheme.borderWidth,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions
                      .map((action) => Padding(
                            padding: const EdgeInsets.only(left: ClassicTheme.margin),
                            child: action,
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 簡単な確認ダイアログを表示
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'キャンセル',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ClassicDialog(
        title: title,
        content: Text(
          message,
          style: ClassicTheme.bodyTextStyle,
        ),
        actions: [
          ClassicButton(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ClassicButton(
            text: confirmText,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  /// 簡単な情報ダイアログを表示
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => ClassicDialog(
        title: title,
        content: Text(
          message,
          style: ClassicTheme.bodyTextStyle,
        ),
        actions: [
          ClassicButton(
            text: buttonText,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// 確認ダイアログを表示（confirm method）
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
    String cancelText = 'キャンセル',
  }) {
    return showConfirm(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
    );
  }
}
