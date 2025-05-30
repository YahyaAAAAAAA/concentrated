import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/viewer/exam_viewer_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/viewer/exam_viewer_states.dart';

class ExamViewerPage extends StatelessWidget {
  const ExamViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<ExamViewerCubit>()..loadSubjects(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Available Exams')),
        body: BlocBuilder<ExamViewerCubit, ExamViewerState>(
          builder: (context, state) {
            if (state is ExamViewerLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExamViewerError) {
              return Center(child: Text(state.message));
            }

            if (state is ExamViewerLoaded) {
              return ListView.builder(
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  final exam = state.exams[index];
                  return ExpansionTile(
                    title: Text(exam.path.subject),
                    subtitle: Text('${exam.questions.length} questions'),
                    children: exam.questions.map((q) {
                      return ListTile(
                        title: Text(q.question),
                        subtitle: Text(q.options.join(' | ')),
                      );
                    }).toList(),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
