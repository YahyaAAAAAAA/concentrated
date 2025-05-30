import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/extract_questions_from_pdf.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/upload_questions.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exam_state.dart';

@injectable
class ExamCubit extends Cubit<ExamState> {
  final ExtractQuestionsFromPDF extraqctQuestionsFromPDFUsecase;
  final UploadQuestions uploadQuestionsUsecase;

  ExamCubit(this.extraqctQuestionsFromPDFUsecase, this.uploadQuestionsUsecase)
      : super(ExamInitial());

  void extractQuestions(String pdfPath) async {
    emit(ExamLoading());
    final result = await extraqctQuestionsFromPDFUsecase(pdfPath);

    result.fold(
      (failure) => emit(ExamError(failure.message)),
      (questions) => emit(ExamExtracted(questions)),
    );
  }

  void uploadQuestions(List<Question> questions, SchoolExamPath path) async {
    emit(ExamLoading());
    final result = await uploadQuestionsUsecase(questions, path);

    result.fold(
      (failure) => emit(ExamError(failure.message)),
      (_) => emit(ExamUploaded()),
    );
  }

  void cutQuestionsNumbering(List<Question> questions) {
    emit(ExamLoading());
    var cleaned = questions.map((q) {
      // Remove leading numbering like "1)", "12)", etc.
      final cleanedText = q.question.trim().replaceFirst(
            RegExp(r'^\d+\)\s*'),
            '',
          );
      return Question(
        question: cleanedText,
        options: q.options,
        answer: q.answer,
      );
    }).toList();

    cleaned = cleaned
        .map(
          (q) => Question(
            question: q.question,
            answer: q.answer,
            options: q.options
                .map(
                  (opt) => opt.trim().replaceFirst(
                        RegExp(r'^[A-Z]\)\s*'),
                        '',
                      ),
                )
                .toList(),
          ),
        )
        .toList();

    emit(ExamExtracted(cleaned));
  }
}
