import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@injectable
class UploadQuestions {
  final ExamRepository repository;

  UploadQuestions(this.repository);

  Future<Either<Failure, void>> call(
      List<Question> questions, SchoolExamPath path) async {
    return await repository.uploadQuestions(questions, path);
  }
}
