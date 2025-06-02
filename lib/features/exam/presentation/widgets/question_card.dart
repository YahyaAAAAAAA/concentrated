import 'package:flutter/material.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.currentQuestionIndex,
    required this.questions,
    required this.question,
    required this.answers,
    this.onChanged,
  });

  final int currentQuestionIndex;
  final List<Question> questions;
  final Question question;
  final List<int?> answers;
  final void Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
              ).trinary(),
              Spacer(),
              Icon(
                Icons.bookmark_outline_outlined,
                size: kNormalIconSize,
              ),
              10.width,
              Icon(
                Icons.report_gmailerrorred_rounded,
                size: kNormalIconSize,
              )
            ],
          ),
          40.height,
          Text(question.question).secondary(),
          10.height,
          Center(
            child: ListView.builder(
              itemCount: question.options.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: RadioListTile<int?>(
                    groupValue:
                        answers.isEmpty ? 0 : answers[currentQuestionIndex],
                    value: i,
                    onChanged: onChanged,
                    title: Text(question.options[i]).secondary(),
                    tileColor: GColors.sand,
                    selectedTileColor: GColors.fern.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kOuterRadius)),
                    selected: answers.isEmpty
                        ? false
                        : answers[currentQuestionIndex] == i,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
