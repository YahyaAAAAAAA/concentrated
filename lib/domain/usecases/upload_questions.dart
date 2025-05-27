import 'package:tweleve_ace/domain/entities/question.dart';
import 'package:tweleve_ace/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/domain/repositories/exam_repo.dart';

class UploadQuestions {
  final ExamRepository repository;

  UploadQuestions(this.repository);

  Future<void> call(List<Question> questions, SchoolExamPath path) async {
    return await repository.uploadQuestions(questions, path);
  }
}
