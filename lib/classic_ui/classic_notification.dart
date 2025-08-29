import 'package:flutter/material.dart';
import 'classic_theme.dart';
import 'classic_button.dart';

/// クラシック調のスナックバー
class ClassicSnackBar extends StatelessWidget {
  final String message;
  final Widget? action;
  final Duration duration;
  final Color? backgroundColor;

  const ClassicSnackBar({
    super.key,
    required this.message,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ClassicTheme.padding),
      decoration: ClassicTheme.raisedDecoration,
      child: Container(
        padding: const EdgeInsets.all(ClassicTheme.padding),
        color: backgroundColor ?? ClassicTheme.buttonFaceColor,
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: ClassicTheme.bodyTextStyle,
              ),
            ),
            if (action != null) ...[
              const SizedBox(width: ClassicTheme.padding),
              action!,
            ],
          ],
        ),
      ),
    );
  }

  /// 簡単なスナックバーを表示
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Color? backgroundColor,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: ClassicSnackBar(
          message: message,
          backgroundColor: backgroundColor,
          action: actionLabel != null
              ? ClassicButton(
                  text: actionLabel,
                  width: 60,
                  height: 20,
                  onPressed: () {
                    scaffoldMessenger.hideCurrentSnackBar();
                    onAction?.call();
                  },
                )
              : null,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 成功メ��セージを表示
  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, backgroundColor: const Color(0xFFD4F6D4));
  }

  /// エラーメッセージを表示
  static void showError(BuildContext context, String message) {
    show(context, message: message, backgroundColor: const Color(0xFFFFD4D4));
  }

  /// 警告メッセージを表示
  static void showWarning(BuildContext context, String message) {
    show(context, message: message, backgroundColor: const Color(0xFFFFF4D4));
  }
}

/// クラシック調のバナー
class ClassicBanner extends StatelessWidget {
  final String message;
  final Widget? leading;
  final List<Widget> actions;
  final Color? backgroundColor;
  final VoidCallback? onDismiss;

  const ClassicBanner({
    super.key,
    required this.message,
    this.leading,
    this.actions = const [],
    this.backgroundColor,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ClassicTheme.raisedDecoration,
      child: Container(
        padding: const EdgeInsets.all(ClassicTheme.padding),
        color: backgroundColor ?? ClassicTheme.buttonFaceColor,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: ClassicTheme.padding),
            ],
            Expanded(
              child: Text(
                message,
                style: ClassicTheme.bodyTextStyle,
              ),
            ),
            ...actions.map((action) => Padding(
                  padding: const EdgeInsets.only(left: ClassicTheme.margin),
                  child: action,
                )),
            if (onDismiss != null)
              Padding(
                padding: const EdgeInsets.only(left: ClassicTheme.margin),
                child: GestureDetector(
                  onTap: onDismiss,
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
              ),
          ],
        ),
      ),
    );
  }
}

/// クラシック調のトーストメッセージ
class ClassicToast {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: ClassicTheme.raisedDecoration,
            child: Container(
              padding: const EdgeInsets.all(ClassicTheme.padding),
              color: backgroundColor ?? ClassicTheme.buttonFaceColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: ClassicTheme.bodyTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => overlayEntry.remove(),
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
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// クラシック調のステータスバー風メッセージ
class ClassicStatusBar extends StatelessWidget {
  final String message;
  final Widget? leading;
  final Widget? trailing;

  const ClassicStatusBar({
    super.key,
    required this.message,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 24,
      decoration: ClassicTheme.sunkenDecoration,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: ClassicTheme.padding),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: ClassicTheme.padding),
            ],
            Expanded(
              child: Text(
                message,
                style: ClassicTheme.bodyTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: ClassicTheme.padding),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
