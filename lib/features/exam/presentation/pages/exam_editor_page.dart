import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/core/extensions/build_context_extenstions.dart';
import 'package:tweleve_ace/core/widgets/app_scaffold.dart';
import 'package:tweleve_ace/core/widgets/app_sub_app_bar.dart';
import 'package:tweleve_ace/core/widgets/primary_button.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exam_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exam_state.dart';
import 'package:tweleve_ace/features/exam/presentation/widgets/path_selector_dialog.dart';

class ExamEditorPage extends StatefulWidget {
  const ExamEditorPage({super.key});

  @override
  State<ExamEditorPage> createState() => _ExamEditorPageState();
}

class _ExamEditorPageState extends State<ExamEditorPage> {
  SchoolExamPath path = SchoolExamPath(
    category: 'school',
    grade: '12.1',
    subject: 'english',
    exam: 'R2024',
  );

  String? pdfPath;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppSubAppBar(title: "Exam Extractor"),
      body: BlocConsumer<ExamCubit, ExamState>(
        listener: (context, state) {
          if (state is ExamError) {
            context.showSnackBar(state.message);
          }
          if (state is ExamUploaded) {
            context.showSnackBar('Exam Uploaded to Database');
          }
        },
        builder: (context, state) {
          if (state is ExamLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExamError) {
            return Center(child: Text(state.message));
          } else if (state is ExamExtracted) {
            final questions = state.questions;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => context.dialog(
                        pageBuilder: (context, _, __) =>
                            PathSelectorDialog(path: path),
                      ),
                      icon: Text('select path'),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<ExamCubit>().cutQuestionsNumbering(
                                questions,
                              ),
                      icon: Text('Cut Numbering'),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<ExamCubit>().uploadQuestions(
                                questions,
                                path,
                              ),
                      icon: Text('Upload'),
                    ),
                    IconButton(
                      onPressed: () => setState(
                        () => questions.add(
                          Question(question: 'New Question', options: []),
                        ),
                      ),
                      icon: Text('Add Question'),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: false,
                    itemCount: questions.length,
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) {
                      final q = questions[index];
                      return EditableQuestionCard(
                        question: q,
                        onRemovePressed: () =>
                            setState(() => questions.removeAt(index)),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              PrimaryButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    allowedExtensions: ['pdf'],
                  );

                  if (result != null) {
                    pdfPath = result.files[0].path;
                  }
                },
                text: "Pick PDF",
              ),
              PrimaryButton(
                onPressed: () {
                  if (pdfPath != null) {
                    context.read<ExamCubit>().extractQuestions(pdfPath!);
                  }
                },
                text: pdfPath ?? "Load Exam",
              ),
            ],
          );
        },
      ),
    );
  }
}

class EditableQuestionCard extends StatefulWidget {
  final Question question;
  final void Function()? onRemovePressed;

  const EditableQuestionCard({
    required this.question,
    this.onRemovePressed,
    super.key,
  });

  @override
  State<EditableQuestionCard> createState() => _EditableQuestionCardState();
}

class _EditableQuestionCardState extends State<EditableQuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                      text: widget.question.question,
                    ),
                    decoration: const InputDecoration(labelText: "Question"),
                    onChanged: (value) => widget.question.question = value,
                  ),
                ),
                IconButton(
                  onPressed: widget.onRemovePressed,
                  icon: Icon(Icons.clear_rounded),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.question.options.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Radio(
                    groupValue: index,
                    value: widget.question.answer,
                    onChanged: (value) =>
                        setState(() => widget.question.answer = index),
                  ),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(
                        text: widget.question.options[index],
                      ),
                      decoration: const InputDecoration(
                        labelText: "Option",
                      ),
                      onChanged: (value) =>
                          widget.question.options[index] = value,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(
                      () => widget.question.options.remove(
                        widget.question.options[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () =>
                  setState(() => widget.question.options.add('New Option')),
              icon: const Icon(Icons.add),
              label: const Text("Add Option"),
            ),
          ],
        ),
      ),
    );
  }
}
