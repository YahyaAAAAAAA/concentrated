import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

class AppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final ButtonStyle? style;

  const AppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconSize,
    this.style,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: style ??
          Theme.of(context).iconButtonTheme.style?.copyWith(
                backgroundColor: WidgetStatePropertyAll(GColors.sand),
              ),
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
