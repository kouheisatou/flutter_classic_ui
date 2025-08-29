import 'package:flutter/material.dart';
import 'classic_theme.dart';

/// クラシック調のプログレスバー
class ClassicProgressBar extends StatelessWidget {
  final double? value;
  final double width;
  final double height;
  final String? label;

  const ClassicProgressBar({
    super.key,
    this.value,
    this.width = 200,
    this.height = 16,
    this.label,
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
        Container(
          width: width,
          height: height,
          decoration: ClassicTheme.sunkenDecoration,
          child: value != null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: width * value!,
                    height: height - 4,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: ClassicTheme.primaryColor,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(2),
                  child: _buildIndeterminateProgress(),
                ),
        ),
      ],
    );
  }

  Widget _buildIndeterminateProgress() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return CustomPaint(
          size: Size(width - 4, height - 4),
          painter: _IndeterminateProgressPainter(value),
        );
      },
    );
  }
}

class _IndeterminateProgressPainter extends CustomPainter {
  final double progress;

  _IndeterminateProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    const barWidth = 30.0;
    final x = (size.width + barWidth) * progress - barWidth;

    if (x < size.width && x + barWidth > 0) {
      final paint = Paint()
        ..color = ClassicTheme.primaryColor
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTWH(
          x.clamp(0, size.width),
          0,
          (x + barWidth).clamp(0, size.width) - x.clamp(0, size.width),
          size.height,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// クラシック調のスピナー
class ClassicSpinner extends StatefulWidget {
  final double size;

  const ClassicSpinner({
    super.key,
    this.size = 16,
  });

  @override
  State<ClassicSpinner> createState() => _ClassicSpinnerState();
}

class _ClassicSpinnerState extends State<ClassicSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SpinnerPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final double progress;

  _SpinnerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final paint = Paint()
      ..color = ClassicTheme.textColor
      ..style = PaintingStyle.fill;

    // 8方向のドット
    for (int i = 0; i < 8; i++) {
      final angle = i * 3.14159 / 4;
      final opacity = (i == (progress * 8).floor()) ? 1.0 : 0.3;

      final dotPaint = Paint()
        ..color = ClassicTheme.textColor.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      final x = center.dx + radius * 0.7 * (i % 2 == 0 ? 1 : 0.7) *
                  (i < 2 || i > 6 ? 1 : (i < 4 ? 0 : -1));
      final y = center.dy + radius * 0.7 * (i % 2 == 0 ? 1 : 0.7) *
                  (i < 4 ? (i < 2 ? -1 : 1) : (i < 6 ? 1 : -1));

      canvas.drawRect(
        Rect.fromCenter(center: Offset(x, y), width: 2, height: 2),
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// クラシック調の砂時計プログレス
class ClassicHourglassProgress extends StatefulWidget {
  final double size;
  final Color? color;

  const ClassicHourglassProgress({
    super.key,
    this.size = 32,
    this.color,
  });

  @override
  State<ClassicHourglassProgress> createState() => _ClassicHourglassProgressState();
}

class _ClassicHourglassProgressState extends State<ClassicHourglassProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _HourglassPainter(
              progress: _animation.value,
              color: widget.color ?? ClassicTheme.textColor,
            ),
          );
        },
      ),
    );
  }
}

class _HourglassPainter extends CustomPainter {
  final double progress;
  final Color color;

  _HourglassPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width * 0.8;
    final height = size.height * 0.8;

    // 砂時計の外枠を描画
    final path = Path();
    path.moveTo(center.dx - width / 2, center.dy - height / 2);
    path.lineTo(center.dx + width / 2, center.dy - height / 2);
    path.lineTo(center.dx, center.dy);
    path.lineTo(center.dx + width / 2, center.dy + height / 2);
    path.lineTo(center.dx - width / 2, center.dy + height / 2);
    path.lineTo(center.dx, center.dy);
    path.close();

    canvas.drawPath(path, paint);

    // 砂を描画
    final sandPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 上の砂 (減っていく)
    final topSandProgress = 1.0 - progress;
    if (topSandProgress > 0) {
      final topSandHeight = height / 2 * topSandProgress * 0.8;
      final topSandPath = Path();
      final topWidth = width / 2 * topSandProgress;
      topSandPath.moveTo(center.dx - topWidth / 2, center.dy - height / 2);
      topSandPath.lineTo(center.dx + topWidth / 2, center.dy - height / 2);
      topSandPath.lineTo(center.dx + topWidth / 4, center.dy - height / 2 + topSandHeight);
      topSandPath.lineTo(center.dx - topWidth / 4, center.dy - height / 2 + topSandHeight);
      topSandPath.close();
      canvas.drawPath(topSandPath, sandPaint);
    }

    // 下の砂 (増えていく)
    if (progress > 0) {
      final bottomSandHeight = height / 2 * progress * 0.8;
      final bottomSandPath = Path();
      final bottomWidth = width / 2 * progress;
      bottomSandPath.moveTo(center.dx - bottomWidth / 4, center.dy + height / 2 - bottomSandHeight);
      bottomSandPath.lineTo(center.dx + bottomWidth / 4, center.dy + height / 2 - bottomSandHeight);
      bottomSandPath.lineTo(center.dx + bottomWidth / 2, center.dy + height / 2);
      bottomSandPath.lineTo(center.dx - bottomWidth / 2, center.dy + height / 2);
      bottomSandPath.close();
      canvas.drawPath(bottomSandPath, sandPaint);
    }

    // 落ちる砂の粒子
    if (progress > 0.1 && progress < 0.9) {
      final particlePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      for (int i = 0; i < 3; i++) {
        final y = center.dy - 4 + (8 * (progress + i * 0.1) % 1);
        canvas.drawCircle(
          Offset(center.dx + (i - 1) * 2, y),
          1,
          particlePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
