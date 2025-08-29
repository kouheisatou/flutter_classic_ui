import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のカードウィジェット
class ClassicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool sunken;

  const ClassicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.sunken = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(ClassicTheme.margin),
      decoration: sunken
          ? ClassicTheme.sunkenDecoration
          : ClassicTheme.raisedDecoration,
      child: Container(
        padding: padding ?? const EdgeInsets.all(ClassicTheme.padding),
        child: child,
      ),
    );
  }
}

/// クラシック調のパネル（フラット）
class ClassicPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const ClassicPanel({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(ClassicTheme.margin),
      decoration: ClassicTheme.flatDecoration,
      child: Container(
        padding: padding ?? const EdgeInsets.all(ClassicTheme.padding),
        child: child,
      ),
    );
  }
}
