import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/domain/entities/question.dart';
import 'package:tweleve_ace/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/domain/usecases/extract_questions_from_pdf.dart';
import 'package:tweleve_ace/domain/usecases/upload_questions.dart';
import 'package:tweleve_ace/presentation/cubits/exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ExtractQuestionsFromPDF extraqctQuestionsFromPDFUsecase;
  final UploadQuestions uploadQuestionsUsecase;

  ExamCubit(this.extraqctQuestionsFromPDFUsecase, this.uploadQuestionsUsecase)
    : super(ExamInitial());

  void extractQuestions(String pdfPath) async {
    emit(ExamLoading());
    try {
      final questions = await extraqctQuestionsFromPDFUsecase(pdfPath);
      emit(ExamExtracted(questions));
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  void uploadQuestions(List<Question> questions, SchoolExamPath path) async {
    emit(ExamLoading());
    try {
      await uploadQuestionsUsecase(questions, path);
      emit(ExamUploaded());
    } catch (e) {
      emit(ExamError(e.toString()));
    }
  }

  void cutQuestionsNumbering(List<Question> questions) {
    emit(ExamLoading());
    var cleaned =
        questions.map((q) {
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

    cleaned =
        cleaned
            .map(
              (q) => Question(
                question: q.question,
                answer: q.answer,
                options:
                    q.options
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
