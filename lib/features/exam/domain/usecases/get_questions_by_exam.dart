import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@injectable
class GetQuestionsByExam {
  final ExamRepository repository;

  GetQuestionsByExam(this.repository);

  Future<Either<Failure, List<Question>>> call(
      String grade, String subject, String exam) {
    return repository.getQuestionsByExam(grade, subject, exam);
  }
}
