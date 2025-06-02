import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';

class QuestionsBottomBar extends StatelessWidget {
  final int currentQuestionIndex;
  final int answersLength;
  final void Function()? onSubmitPressed;
  final void Function()? onNextPressed;
  final void Function()? onPreviousPressed;

  const QuestionsBottomBar({
    super.key,
    required this.currentQuestionIndex,
    required this.answersLength,
    this.onNextPressed,
    this.onPreviousPressed,
    this.onSubmitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kOuterRadius),
        topRight: Radius.circular(kOuterRadius),
      ),
      child: ColoredBox(
        color: GColors.sand,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Row(
            children: [
              PrimaryButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                onPressed: onSubmitPressed,
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      Icons.done_all_rounded,
                      color: GColors.white,
                      size: kNormalIconSize,
                    ),
                    Text('Submit Answers').secondaryOnSurface(),
                  ],
                ),
              ),
              Spacer(),
              TrinaryButton(
                onPressed: onPreviousPressed,
                icon: Icons.arrow_back_rounded,
                hasBorder: false,
                iconColor: currentQuestionIndex > 0
                    ? GColors.black
                    : GColors.black.withValues(alpha: 0.3),
              ),
              20.toWidth(),
              TrinaryButton(
                onPressed: onNextPressed,
                icon: Icons.arrow_forward_rounded,
                hasBorder: false,
                iconColor: currentQuestionIndex < answersLength - 1
                    ? GColors.black
                    : GColors.black.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
