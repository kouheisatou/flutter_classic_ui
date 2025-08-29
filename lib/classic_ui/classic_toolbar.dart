import 'package:flutter/material.dart';

class ClassicToolbar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? actions;

  const ClassicToolbar({
    super.key,
    this.leading,
    this.trailing,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFC0C0C0),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            const SizedBox(width: 8),
            leading!,
          ],
          const Spacer(),
          if (actions != null) ...actions!,
          if (trailing != null) ...[
            trailing!,
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
