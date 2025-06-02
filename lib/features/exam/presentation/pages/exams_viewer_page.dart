import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/config/routes.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/string_extensions.dart';
import 'package:tweleve_ace/core/widgets/app_scaffold.dart';
import 'package:tweleve_ace/core/widgets/app_sub_app_bar.dart';
import 'package:tweleve_ace/core/widgets/loading_buttons.dart';
import 'package:tweleve_ace/core/widgets/row_button.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exams/exams_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exams/exams_states.dart';

class ExamsViewerPage extends StatefulWidget {
  final String grade;
  final String subject;

  const ExamsViewerPage({
    super.key,
    required this.grade,
    required this.subject,
  });

  @override
  State<ExamsViewerPage> createState() => _ExamsViewerPageState();
}

class _ExamsViewerPageState extends State<ExamsViewerPage> {
  @override
  void initState() {
    super.initState();

    context.read<ExamsCubit>().getExamsBySubject(widget.grade, widget.subject);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppSubAppBar(
        title: '${widget.subject.capitalized} Exams',
      ),
      body: BlocConsumer<ExamsCubit, ExamsStates>(listener: (context, state) {
        if (state is ExamsError) {
          context.showSnackBar(state.message);
        }
      }, builder: (context, state) {
        if (state is ExamsLoaded) {
          final exams = state.exams;

          return ListView.separated(
            itemCount: exams.length,
            separatorBuilder: (context, index) => 10.height,
            itemBuilder: (context, index) => RowButton(
              icon: Icons.quiz_outlined,
              text: exams[index],
              onPressed: () =>
                  context.pushNamed(APR.questions.name, pathParameters: {
                'grade': widget.grade,
                'subject': widget.subject,
                'exam': exams[index],
              }),
            ),
          );
        } else if (state is ExamsError) {
          //todo error widget
          return Text('data');
        } else {
          return LoadingButtons();
        }
      }),
    );
  }
}
