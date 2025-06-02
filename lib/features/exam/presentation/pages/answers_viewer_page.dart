import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_scaffold.dart';
import 'package:tweleve_ace/core/widgets/app_sub_app_bar.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/secondary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/answer_card.dart';

class AnswersViewerPage extends StatefulWidget {
  final String grade;
  final String subject;
  final String exam;
  final List<Question> questions;
  final List<int?> answers;

  const AnswersViewerPage({
    super.key,
    required this.grade,
    required this.subject,
    required this.exam,
    required this.questions,
    required this.answers,
  });

  @override
  State<AnswersViewerPage> createState() => _AnswersViewerPageState();
}

class _AnswersViewerPageState extends State<AnswersViewerPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showResultDialog();
      },
    );
  }

  Future<Object?> showResultDialog() {
    return context.dialog(
      barrierDismissible: false,
      pageBuilder: (context, _, __) {
        final total = widget.questions.length;
        final correct = List.generate(
                total, (i) => widget.answers[i] == widget.questions[i].answer)
            .where((v) => v)
            .length;
        final percent = total == 0 ? 0 : ((correct / total) * 100).round();

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.question_answer_rounded,
                  size: kBigIconSize,
                ),
                const Text('Your Results').primary(),
                Spacer(),
                SecondaryButton(
                  onPressed: () => context.pop(),
                  icon: Icons.clear_rounded,
                  padding: EdgeInsets.zero,
                  iconSize: kSmallIconSize,
                  width: 30,
                  height: 30,
                ),
              ],
            ),
            content: CircularPercentIndicator(
              radius: 50,
              lineWidth: 9,
              percent: percent / 100,
              progressColor: GColors.fern,
              backgroundColor: GColors.fern.withValues(alpha: 0.3),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundWidth: 10,
              animation: true,
              footer: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$correct out of $total').trinary(),
              ),
              center: Text('$percent%').secondary(fontWeight: FontWeight.bold),
            ),
            actions: [
              TrinaryButton(
                text: 'Go Back',
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                textSize: kSmallFontSize,
                onPressed: () {
                  //theres no way this is right
                  context.pop();
                  context.pop();
                  context.pop();
                },
              ),
              PrimaryButton(
                onPressed: () => context.pop(),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                textSize: kSmallFontSize,
                text: 'See Answers',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.pop();
          context.pop();
        }
      },
      child: AppScaffold(
        appBar: AppSubAppBar(
          title: 'Your Answers',
          onBack: () {
            context.pop();
            context.pop();
          },
        ),
        body: ListView.builder(
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            final question = widget.questions[index];
            final userAnswer = widget.answers[index];
            final correctAnswer = question.answer;

            return AnswerCard(
              question: question,
              correctAnswer: correctAnswer,
              userAnswer: userAnswer,
            );
          },
        ),
      ),
    );
  }
}
