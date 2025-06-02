import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_button.dart';

class PrimaryButton extends AppButton {
  final double? width;
  final double? height;

  const PrimaryButton({
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
      width: width,
      height: height,
      child: AppButton(
        onPressed: onPressed,
        padding: padding,
        radius: radius,
        style: style ??
            Theme.of(context).iconButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStatePropertyAll(GColors.fern),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(radius ?? kOuterRadius),
                    ),
                  ),
                ),
        text: text,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        textColor: textColor,
        textSize: textSize,
        child: child,
      ),
    );
  }
}
