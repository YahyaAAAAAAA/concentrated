import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/secondary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';

class RowButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData icon;
  final double? iconSize;

  const RowButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return TrinaryButton(
      onPressed: onPressed,
      hasBorder: false,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(GColors.sand),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        spacing: 5,
        children: [
          SecondaryButton(
            onPressed: null,
            icon: icon,
            iconSize: iconSize,
          ),
          Text(text).secondary(),
          Spacer(),
          PrimaryButton(
            onPressed: onPressed,
            icon: Icons.arrow_forward_ios_rounded,
          ),
        ],
      ),
    );
  }
}
