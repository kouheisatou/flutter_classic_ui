import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のテキストフィールド
class ClassicTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? label; // Alternative to labelText
  final bool obscureText;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final double? width;
  final double? height;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const ClassicTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.label,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.width,
    this.height,
    this.enabled = true,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final displayLabel = labelText ?? label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (displayLabel != null) ...[
          Text(
            displayLabel,
            style: ClassicTheme.bodyTextStyle,
          ),
          const SizedBox(height: 4),
        ],
        Container(
          width: width,
          height: height ?? (maxLines == 1 ? 24 : null),
          decoration: ClassicTheme.sunkenDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              maxLines: maxLines,
              onChanged: onChanged,
              enabled: enabled,
              keyboardType: keyboardType,
              validator: validator,
              style: ClassicTheme.bodyTextStyle.copyWith(
                color: enabled ? ClassicTheme.textColor : Colors.grey,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ClassicTheme.bodyTextStyle.copyWith(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// クラシック調のドロップダウン
class ClassicDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final double? width;

  const ClassicDropdown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 24,
      decoration: ClassicTheme.sunkenDecoration,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ClassicTheme.surfaceColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items?.map((item) {
                return DropdownMenuItem<T>(
                  value: item.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ClassicTheme.surfaceColor,
                    ),
                    child: item.child,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              hint: hint != null
                  ? Text(hint!, style: ClassicTheme.bodyTextStyle)
                  : null,
              style: ClassicTheme.bodyTextStyle,
              iconSize: 16,
              isDense: true,
              dropdownColor: ClassicTheme.surfaceColor,
              icon: Container(
                width: 16,
                height: 16,
                decoration: ClassicTheme.raisedDecoration,
                child: const Center(
                  child: Text(
                    '▼',
                    style: TextStyle(
                      fontSize: 8,
                      color: ClassicTheme.textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
