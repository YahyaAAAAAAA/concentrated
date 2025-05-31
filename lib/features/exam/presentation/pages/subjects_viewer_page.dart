import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/extensions/int_extenstions.dart';
import 'package:tweleve_ace/core/extensions/text_extensions.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_states.dart';

//TODO tmro => on subject click
// => fetch sub docs and display them (available exams) =>
// on exam click => load questions => on submit => show resutls.

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.read<SubjectsCubit>().getSubjectsByGrade('12.1');
              },
              child: Text('data'))
        ],
      ),
      body: BlocConsumer<SubjectsCubit, SubjectsStates>(
          listener: (context, state) {
        if (state is SubjectsError) {
          context.showSnackBar(state.message);
        }
      }, builder: (context, state) {
        if (state is SubjectsLoaded) {
          final subjects = state.subjects;
          return Column(
            children: [
              ListView.separated(
                itemCount: subjects.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, index) =>
                    Text(subjects[index]).secondary(),
              ),
            ],
          );
        } else if (state is SubjectsError) {
          return Text('data');
        } else {
          return Text('loading').primary();
        }
      }),
    );
  }
}
