import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/config/routes.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/string_extensions.dart';
import 'package:tweleve_ace/core/utils/subjects_to_icons.dart';
import 'package:tweleve_ace/core/widgets/app_scaffold.dart';
import 'package:tweleve_ace/core/widgets/app_sub_app_bar.dart';
import 'package:tweleve_ace/core/widgets/loading_buttons.dart';
import 'package:tweleve_ace/core/widgets/row_button.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_states.dart';

class SubjectsViewerPage extends StatefulWidget {
  final String grade;

  const SubjectsViewerPage({
    super.key,
    required this.grade,
  });

  @override
  State<SubjectsViewerPage> createState() => _SubjectsViewerPageState();
}

class _SubjectsViewerPageState extends State<SubjectsViewerPage> {
  @override
  void initState() {
    super.initState();

    context.read<SubjectsCubit>().getSubjectsByGrade(widget.grade);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppSubAppBar(
        title: '${widget.grade} Subjects',
      ),
      body: BlocConsumer<SubjectsCubit, SubjectsStates>(
          listener: (context, state) {
        if (state is SubjectsError) {
          context.showSnackBar(state.message);
        }
      }, builder: (context, state) {
        if (state is SubjectsLoaded) {
          final subjects = state.subjects;
          return ListView.separated(
            itemCount: subjects.length,
            separatorBuilder: (context, index) => 10.height,
            itemBuilder: (context, index) => RowButton(
              onPressed: () =>
                  context.pushNamed(APR.exams.name, pathParameters: {
                'grade': widget.grade,
                'subject': subjects[index],
              }),
              icon: SubjectsToIcons.getIconForSubject(subjects[index]) ??
                  FontAwesomeIcons.book,
              text: subjects[index].capitalized,
            ),
          );
        } else if (state is SubjectsError) {
          return Text('data');
        } else {
          return LoadingButtons();
        }
      }),
    );
  }
}
