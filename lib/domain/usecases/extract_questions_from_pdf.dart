import 'package:tweleve_ace/domain/entities/question.dart';
import 'package:tweleve_ace/domain/repositories/exam_repo.dart';

class ExtractQuestionsFromPDF {
  final ExamRepository repository;

  ExtractQuestionsFromPDF(this.repository);

  Future<List<Question>> call(String pdfPath) async {
    return await repository.extractQuestionsFromPDF(pdfPath);
  }
}
