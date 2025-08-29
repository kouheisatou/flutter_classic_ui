import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// Button variants for different styles
enum ClassicButtonVariant {
  primary,
  danger,
  normal,
}

/// クラシック調のボタンウィジェット
class ClassicButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool enabled;
  final ClassicButtonVariant variant;

  const ClassicButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.enabled = true,
    this.variant = ClassicButtonVariant.normal,
  });

  @override
  State<ClassicButton> createState() => _ClassicButtonState();
}

class _ClassicButtonState extends State<ClassicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled && widget.onPressed != null;
    final buttonColor = _getButtonColor();

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width ?? 80,
        height: widget.height ?? 24,
        transform: _isPressed
            ? Matrix4.translationValues(1, 1, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: _isPressed
            ? ClassicTheme.sunkenDecoration.copyWith(color: buttonColor)
            : ClassicTheme.raisedDecoration.copyWith(color: buttonColor),
        child: Center(
          child: Text(
            widget.text,
            style: ClassicTheme.buttonTextStyle.copyWith(
              color: isEnabled ? _getTextColor() : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor() {
    switch (widget.variant) {
      case ClassicButtonVariant.primary:
        return const Color(0xFF4A90E2);
      case ClassicButtonVariant.danger:
        return const Color(0xFFE24A4A);
      case ClassicButtonVariant.normal:
        return ClassicTheme.buttonFaceColor;
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ClassicButtonVariant.primary:
      case ClassicButtonVariant.danger:
        return Colors.white;
      case ClassicButtonVariant.normal:
        return ClassicTheme.textColor;
    }
  }
}
