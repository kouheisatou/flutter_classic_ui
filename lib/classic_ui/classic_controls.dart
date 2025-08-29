import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のチェックボックス
class ClassicCheckbox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  const ClassicCheckbox({
    super.key,
    this.value,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!(value ?? false)) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 13,
            height: 13,
            decoration: ClassicTheme.sunkenDecoration,
            child: Center(
              child: value == true
                  ? const Text(
                      '×',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: ClassicTheme.textColor,
                        fontFamily: 'monospace',
                      ),
                    )
                  : null,
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: 6),
            Text(
              label!,
              style: ClassicTheme.bodyTextStyle,
            ),
          ],
        ],
      ),
    );
  }
}

/// クラシック調のラジオボタン
class ClassicRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;

  const ClassicRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 13,
            height: 13,
            decoration: ClassicTheme.sunkenDecoration,
            child: Center(
              child: isSelected
                  ? Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: ClassicTheme.textColor,
                        shape: BoxShape.rectangle,
                      ),
                    )
                  : null,
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label!,
                style: ClassicTheme.bodyTextStyle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// クラシック調のスイッチ
class ClassicSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;

  const ClassicSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 16,
            decoration: ClassicTheme.sunkenDecoration,
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 14,
                    height: 12,
                    margin: const EdgeInsets.all(2),
                    decoration: ClassicTheme.raisedDecoration,
                  ),
                ),
              ],
            ),
          ),
          if (label != null) ...[
            const SizedBox(width: 6),
            Text(
              label!,
              style: ClassicTheme.bodyTextStyle,
            ),
          ],
        ],
      ),
    );
  }
}

/// クラシック調のスライダー
class ClassicSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final double width;

  const ClassicSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.label,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: ClassicTheme.bodyTextStyle,
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          width: width,
          height: 20,
          child: GestureDetector(
            onPanStart: onChanged != null ? (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final newValue = min + (localPosition.dx / width) * (max - min);
              onChanged!(newValue.clamp(min, max));
            } : null,
            onPanUpdate: onChanged != null ? (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final newValue = min + (localPosition.dx / width) * (max - min);
              onChanged!(newValue.clamp(min, max));
            } : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // トラック
                Container(
                  width: width,
                  height: 4,
                  decoration: ClassicTheme.sunkenDecoration,
                ),
                // スライダー
                Positioned(
                  left: (value - min) / (max - min) * (width - 16),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: ClassicTheme.raisedDecoration,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
