import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';

class AdminCard extends StatelessWidget {
  final String count;
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const AdminCard({
    super.key,
    required this.count,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(12),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(GColors.sand),
        ),
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: GColors.fern.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(kOuterRadius),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    icon,
                    size: kNormalFontSize,
                    color: GColors.fern,
                  ),
                ),
                10.width,
                Text(
                  text,
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: kSmallFontSize,
                  ),
                ).trinary(),
              ],
            ),
            PrimaryButton(
              onPressed: onPressed,
              icon: Icons.arrow_forward_ios_rounded,
              iconSize: kSmallIconSize - 3,
            ),
          ],
        ));
  }
}
