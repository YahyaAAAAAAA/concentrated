import 'package:tweleve_ace/domain/entities/question.dart';
import 'package:tweleve_ace/domain/entities/school_exam_path.dart';

abstract class ExamRepository {
  Future<List<Question>> extractQuestionsFromPDF(String pdfPath);

  Future<void> uploadQuestions(List<Question> questions, SchoolExamPath path);
}
