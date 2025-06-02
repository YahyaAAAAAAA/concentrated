import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/config/routes.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/core/utils/constants.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/core/widgets/trinary_button.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/get_questions_by_exam.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_states.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/submit_answers_dialog.dart';

@injectable
class QuestionsCubit extends Cubit<QuestionsStates> {
  final GetQuestionsByExam getQuestions;

  QuestionsCubit(this.getQuestions) : super(QuestionsInitial());

  Future<void> getQuestionsByExam(
      String grade, String subject, String exam) async {
    emit(QuestionsLoading());

    final result = await getQuestions(grade, subject, exam);
    result.fold(
      (failure) {
        if (!isClosed) emit(QuestionsError(failure.message));
      },
      (subjects) {
        if (!isClosed) emit(QuestionsLoaded(subjects));
      },
    );
  }

  Future<dynamic> submitAnswersDialog(
    BuildContext context, {
    required String grade,
    required String subject,
    required String exam,
    required List<int?> answers,
  }) async {
    //check if all questions answered
    final unansweredIndexes = [
      for (int i = 0; i < answers.length; i++)
        if (answers[i] == null) (i + 1)
    ];
    if (unansweredIndexes.isNotEmpty) {
      context.showSnackBar('please answer question(s) : $unansweredIndexes');
      return false;
    }

    //can submit
    return await context.sheet(
      builder: (_) {
        return SubmitAnswersDialog(
          onCancelPressed: () => context.pop(),
          onSubmitPressed: () {
            final questionsState = context.read<QuestionsCubit>().state;
            context.pop();
            context.pushNamed(
              APR.answers.name,
              pathParameters: {
                'grade': grade,
                'subject': subject,
                'exam': exam,
              },
              extra: {
                'questions': questionsState is QuestionsLoaded
                    ? questionsState.questions
                    : [],
                'answers': answers,
              },
            );
          },
        );
      },
    );
  }

  Future<Object?> confirmationDialog(BuildContext context) {
    return context.dialog<bool>(
      pageBuilder: (_, __, ___) => AlertDialog(
        title: FittedBox(
          child: Row(
            spacing: 10,
            children: [
              Icon(
                Icons.quiz_outlined,
                size: kBigIconSize,
              ),
              const Text('You sure you want to quit ?')
                  .secondary(fontWeight: FontWeight.bold),
            ],
          ),
        ),
        actions: [
          TrinaryButton(
            onPressed: () => context.pop(false),
            text: 'Cancel',
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
            textSize: kSmallFontSize,
          ),
          PrimaryButton(
            onPressed: () {
              context.pop(true);
              context.pop(true);
            },
            text: 'Yes, quit',
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
            textSize: kSmallFontSize,
          ),
        ],
      ),
    );
  }
}
