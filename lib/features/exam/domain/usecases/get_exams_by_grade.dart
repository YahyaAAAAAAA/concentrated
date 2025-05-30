import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/entities/loaded_exam.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@injectable
class GetExamsByGrade {
  final ExamRepository repository;

  GetExamsByGrade(this.repository);

  Future<Either<Failure, List<LoadedExam>>> call(String grade) {
    return repository.getExamsByGrade(grade);
  }
}
