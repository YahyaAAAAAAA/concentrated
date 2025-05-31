import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@injectable
class GetSubjectsByGrade {
  final ExamRepository repository;

  GetSubjectsByGrade(this.repository);

  Future<Either<Failure, List<String>>> call(String grade) {
    return repository.getSubjectsByGrade(grade);
  }
}
