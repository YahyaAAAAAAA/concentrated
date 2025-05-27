import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/color_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_button.dart';

class TrinaryButton extends AppButton {
  final bool? hasBorder;
  const TrinaryButton({
    this.hasBorder = true,
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
    return AppButton(
      onPressed: onPressed,
      padding: padding,
      style: style ??
          Theme.of(context).iconButtonTheme.style?.copyWith(
                backgroundColor: WidgetStatePropertyAll(GColors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? kOuterRadius),
                    side: hasBorder!
                        ? BorderSide(
                            color: GColors.sand.shade600,
                            width: 1,
                          )
                        : BorderSide.none,
                  ),
                ),
              ),
      text: text,
      icon: icon,
      iconColor: iconColor ?? GColors.black,
      textColor: textColor ?? GColors.black,
      iconSize: iconSize,
      textSize: textSize,
      child: child,
    );
  }
}
