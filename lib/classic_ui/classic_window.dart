import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のウィンドウウィジェット
class ClassicWindow extends StatelessWidget {
  final String title;
  final Widget child;
  final double? width;
  final double? height;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const ClassicWindow({
    super.key,
    required this.title,
    required this.child,
    this.width,
    this.height,
    this.showCloseButton = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: const BoxDecoration(
        color: ClassicTheme.surfaceColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // タイトルバー
          Container(
            width: double.infinity,
            height: 32,
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
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: ClassicTheme.titleTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (showCloseButton) ...[
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: ClassicTheme.surfaceColor,
                        border: Border.all(
                          color: ClassicTheme.borderColor,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '×',
                          style: TextStyle(
                            color: ClassicTheme.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // コンテンツエリア - パディングなし
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
