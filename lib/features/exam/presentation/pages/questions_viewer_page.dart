import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_states.dart';

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
  @override
  void initState() {
    super.initState();

    context.read<QuestionsCubit>().getQuestionsByExam(
          widget.grade,
          widget.subject,
          widget.exam,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                // context.read<SubjectsCubit>().getSubjectsByGrade('12.1');
              },
              child: Text('data'))
        ],
      ),
      body: BlocConsumer<QuestionsCubit, QuestionsStates>(
          listener: (context, state) {
        if (state is QuestionsError) {
          context.showSnackBar(state.message);
        }
      }, builder: (context, state) {
        if (state is QuestionsLoaded) {
          final exams = state.questions;
          return Column(
            children: [
              ListView.separated(
                itemCount: exams.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, index) =>
                    Text(exams[index].question).secondary(),
              ),
            ],
          );
        } else if (state is QuestionsError) {
          return Text('data');
        } else {
          return Text('loading').primary();
        }
      }),
    );
  }
}
