import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_button.dart';

class SecondaryButton extends AppButton {
  final double? width;
  final double? height;

  const SecondaryButton({
    this.height,
    this.width,
    super.key,
    super.onPressed,
    super.child,
    super.text,
    super.icon,
    super.style,
    super.iconColor,
    super.textColor,
    super.iconSize,
    super.textSize,
    super.padding,
    super.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: AppButton(
        onPressed: onPressed,
        padding: padding,
        style: style ??
            Theme.of(context).iconButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStatePropertyAll(
                      GColors.fern.withValues(alpha: 0.3)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(radius ?? kOuterRadius),
                    ),
                  ),
                ),
        text: text,
        icon: icon,
        iconColor: iconColor ?? GColors.fern,
        textColor: textColor ?? GColors.fern,
        iconSize: iconSize,
        textSize: textSize,
        child: child,
      ),
    );
  }
}
