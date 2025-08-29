import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のリストタイル
class ClassicListTile extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;

  const ClassicListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.selected = false,
  });

  @override
  State<ClassicListTile> createState() => _ClassicListTileState();
}

class _ClassicListTileState extends State<ClassicListTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.onTap != null ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.onTap != null ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ClassicTheme.padding,
          vertical: ClassicTheme.padding / 2,
        ),
        decoration: BoxDecoration(
          color: widget.selected
              ? ClassicTheme.primaryColor
              : (_isPressed ? ClassicTheme.surfaceColor : ClassicTheme.buttonFaceColor),
        ),
        child: Row(
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: ClassicTheme.padding),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.title != null)
                    DefaultTextStyle(
                      style: ClassicTheme.bodyTextStyle.copyWith(
                        color: widget.selected ? Colors.white : ClassicTheme.textColor,
                      ),
                      child: widget.title!,
                    ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: ClassicTheme.bodyTextStyle.copyWith(
                        fontSize: ClassicTheme.baseFontSize - 1,
                        color: widget.selected ? Colors.white70 : Colors.grey,
                      ),
                      child: widget.subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: ClassicTheme.padding),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

/// クラシック調のリストビュー
class ClassicListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const ClassicListView({
    super.key,
    required this.children,
    this.controller,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ClassicTheme.sunkenDecoration,
      child: ListView(
        controller: controller,
        shrinkWrap: shrinkWrap,
        padding: padding,
        children: children,
      ),
    );
  }
}

/// ClassicList - Alias for ClassicListView for backward compatibility
class ClassicList extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const ClassicList({
    super.key,
    required this.children,
    this.controller,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClassicListView(
      controller: controller,
      shrinkWrap: shrinkWrap,
      padding: padding,
      children: children,
    );
  }
}

/// ClassicListItem - Alias for ClassicListTile for backward compatibility
class ClassicListItem extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;

  const ClassicListItem({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClassicListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      selected: selected,
    );
  }
}

/// クラシック調のスクロールバー
class ClassicScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;

  const ClassicScrollbar({
    super.key,
    required this.child,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 16,
      child: child,
    );
  }
}

/// クラシック調のグリッドビュー
class ClassicGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool shrinkWrap;

  const ClassicGridView({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = ClassicTheme.margin,
    this.mainAxisSpacing = ClassicTheme.margin,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ClassicTheme.sunkenDecoration,
      padding: const EdgeInsets.all(ClassicTheme.margin),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        shrinkWrap: shrinkWrap,
        children: children,
      ),
    );
  }
}
