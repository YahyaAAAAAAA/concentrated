import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final ButtonStyle? style;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final double? radius;

  const AppButton({
    super.key,
    this.onPressed,
    this.child,
    this.text,
    this.icon,
    this.style,
    this.iconColor,
    this.textColor,
    this.iconSize,
    this.textSize,
    this.padding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.all(12),
      style: style,
      icon: text != null
          ? Text(
              text!,
              style: TextStyle(
                color: textColor ?? GColors.white,
                fontSize: textSize ?? kNormalFontSize,
              ),
            )
          : icon != null
              ? Icon(
                  icon,
                  size: iconSize ?? kNormalIconSize,
                  color: iconColor ?? GColors.white,
                )
              : child ?? 0.width,
    );
  }
}
