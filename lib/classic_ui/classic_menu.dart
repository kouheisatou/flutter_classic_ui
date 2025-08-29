import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のボトムシート
class ClassicBottomSheet extends StatelessWidget {
  final String? title;
  final Widget child;
  final List<Widget>? actions;
  final double? height;

  const ClassicBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.actions,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Container(
        decoration: ClassicTheme.raisedDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
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
                        title!,
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
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ClassicTheme.padding),
                color: ClassicTheme.surfaceColor,
                child: child,
              ),
            ),
            if (actions != null && actions!.isNotEmpty)
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
                  children: actions!
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

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    List<Widget>? actions,
    double? height,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ClassicBottomSheet(
        title: title,
        child: child,
        actions: actions,
        height: height,
      ),
    );
  }
}

/// クラシック調のメニュー項目
class ClassicMenuItem extends StatefulWidget {
  final String text;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;

  const ClassicMenuItem({
    super.key,
    required this.text,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
  });

  @override
  State<ClassicMenuItem> createState() => _ClassicMenuItemState();
}

class _ClassicMenuItemState extends State<ClassicMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: ClassicTheme.padding,
            vertical: ClassicTheme.padding / 2,
          ),
          color: _isHovered && widget.enabled
              ? ClassicTheme.primaryColor
              : ClassicTheme.surfaceColor,
          child: Row(
            children: [
              if (widget.leading != null) ...[
                DefaultTextStyle(
                  style: ClassicTheme.bodyTextStyle.copyWith(
                    color: _isHovered && widget.enabled
                        ? Colors.white
                        : (widget.enabled ? ClassicTheme.textColor : Colors.grey),
                  ),
                  child: widget.leading!,
                ),
                const SizedBox(width: ClassicTheme.padding),
              ],
              Expanded(
                child: Text(
                  widget.text,
                  style: ClassicTheme.bodyTextStyle.copyWith(
                    color: _isHovered && widget.enabled
                        ? Colors.white
                        : (widget.enabled ? ClassicTheme.textColor : Colors.grey),
                  ),
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: ClassicTheme.padding),
                DefaultTextStyle(
                  style: ClassicTheme.bodyTextStyle.copyWith(
                    color: _isHovered && widget.enabled
                        ? Colors.white
                        : (widget.enabled ? ClassicTheme.textColor : Colors.grey),
                  ),
                  child: widget.trailing!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// クラシック調のポップアップメニュー
class ClassicPopupMenu extends StatelessWidget {
  final List<ClassicMenuItem> items;
  final double? width;

  const ClassicPopupMenu({
    super.key,
    required this.items,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      decoration: ClassicTheme.raisedDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map((item) => Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ClassicTheme.borderColor,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: item,
                ))
            .toList(),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required RelativeRect position,
    required List<ClassicMenuItem> items,
    double? width,
  }) {
    return showMenu<T>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<T>(
          enabled: false,
          padding: EdgeInsets.zero,
          child: ClassicPopupMenu(
            items: items,
            width: width,
          ),
        ),
      ],
    );
  }
}

/// クラシック調のメニューバー
class ClassicMenuBar extends StatelessWidget {
  final List<ClassicMenuBarItem> items;

  const ClassicMenuBar({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: ClassicTheme.flatDecoration,
      child: Row(
        children: items
            .map((item) => _MenuBarButton(item: item))
            .toList(),
      ),
    );
  }
}

class ClassicMenuBarItem {
  final String title;
  final List<ClassicMenuItem> items;

  const ClassicMenuBarItem({
    required this.title,
    required this.items,
  });
}

class _MenuBarButton extends StatefulWidget {
  final ClassicMenuBarItem item;

  const _MenuBarButton({required this.item});

  @override
  State<_MenuBarButton> createState() => _MenuBarButtonState();
}

class _MenuBarButtonState extends State<_MenuBarButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => _showMenu(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: ClassicTheme.padding),
        decoration: _isPressed ? ClassicTheme.sunkenDecoration : null,
        child: Center(
          child: Text(
            widget.item.title,
            style: ClassicTheme.bodyTextStyle,
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    ClassicPopupMenu.show(
      context,
      position: position,
      items: widget.item.items,
    );
  }
}
