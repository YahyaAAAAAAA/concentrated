import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';

class AnswerCard extends StatelessWidget {
  final Question question;
  final int correctAnswer;
  final int? userAnswer;

  const AnswerCard({
    super.key,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
          ).secondary(),
          10.height,
          ListView.builder(
            itemCount: question.options.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, optIdx) {
              final isCorrect = optIdx == correctAnswer;
              final isUser = userAnswer == optIdx;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 4,
                ),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kOuterRadius),
                    color: isCorrect
                        ? GColors.fern.withValues(alpha: 0.3)
                        : isUser
                            ? GColors.redShade3.withValues(alpha: 0.3)
                            : GColors.sand,
                  ),
                  child: Row(
                    children: [
                      Text(
                        question.options[optIdx],
                      ).secondary(),
                      if (isCorrect) ...[
                        5.width,
                        const Text('(Correct)').trinary(),
                      ],
                      if (isUser && !isCorrect) ...[
                        5.width,
                        const Text('(Your answer)').trinary(),
                      ],
                      Spacer(),
                      Icon(
                        isCorrect
                            ? Icons.check_circle
                            : isUser
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                        color: isCorrect
                            ? GColors.fern
                            : isUser
                                ? GColors.redShade3
                                : GColors.black,
                        size: kNormalIconSize,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
