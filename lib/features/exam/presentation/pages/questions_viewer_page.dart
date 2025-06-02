import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/utils/dummy.dart';
import 'package:tweleve_ace/core/utils/global_colors.dart';
import 'package:tweleve_ace/core/widgets/app_scaffold.dart';
import 'package:tweleve_ace/core/widgets/app_sub_app_bar.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_states.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/question_card.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/questions_bottom_bar.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/questions_indicator_bar.dart';

class QuestionsViewerPage extends StatefulWidget {
  final String grade;
  final String subject;
  final String exam;

  const QuestionsViewerPage({
    super.key,
    required this.grade,
    required this.subject,
    required this.exam,
  });

  @override
  State<QuestionsViewerPage> createState() => _QuestionsViewerPageState();
}

class _QuestionsViewerPageState extends State<QuestionsViewerPage> {
  List<int?> answers = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<QuestionsCubit>().getQuestionsByExam(
          widget.grade,
          widget.subject,
          widget.exam,
        );
  }

  void nextQuestion(int total) {
    if (currentQuestionIndex < total - 1) {
      setState(() => currentQuestionIndex++);
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await context.read<QuestionsCubit>().confirmationDialog(context);
        }
      },
      child: AppScaffold(
        appBar: AppSubAppBar(
          title: widget.exam,
          onBack: () =>
              context.read<QuestionsCubit>().confirmationDialog(context),
        ),
        body: BlocConsumer<QuestionsCubit, QuestionsStates>(
          listener: (context, state) {
            if (state is QuestionsError) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            if (state is QuestionsLoaded) {
              final questions = state.questions;

              //initialize answers once
              if (answers.length != questions.length) {
                answers = List<int?>.filled(questions.length, null);
              }

              final question = questions[currentQuestionIndex];

              return buildExamElements(questions, question);
            } else if (state is QuestionsError) {
              return Center(child: Text(state.message));
            } else {
              return Skeletonizer(
                enabled: true,
                containersColor: GColors.sand,
                child: buildExamElements(
                  [
                    Dummy.question,
                    Dummy.question,
                    Dummy.question,
                    Dummy.question,
                    Dummy.question,
                  ],
                  Dummy.question,
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<QuestionsCubit, QuestionsStates>(
          builder: (context, state) => Skeletonizer(
            enabled: state is! QuestionsLoaded,
            child: QuestionsBottomBar(
              currentQuestionIndex: currentQuestionIndex,
              answersLength: answers.length,
              onSubmitPressed: () =>
                  context.read<QuestionsCubit>().submitAnswersDialog(
                        context,
                        grade: widget.grade,
                        subject: widget.subject,
                        exam: widget.exam,
                        answers: answers,
                      ),
              onPreviousPressed:
                  currentQuestionIndex > 0 ? previousQuestion : null,
              onNextPressed: currentQuestionIndex < answers.length - 1
                  ? () => nextQuestion(answers.length)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Column buildExamElements(List<Question> questions, Question question) {
    return Column(
      children: [
        QuestionsIndicatorBar(
          index: currentQuestionIndex,
          listLength: answers.length,
        ),
        20.height,
        QuestionCard(
          currentQuestionIndex: currentQuestionIndex,
          questions: questions,
          question: question,
          answers: answers,
          onChanged: (value) => setState(() {
            answers[currentQuestionIndex] = value;
          }),
        ),
      ],
    );
  }
}
