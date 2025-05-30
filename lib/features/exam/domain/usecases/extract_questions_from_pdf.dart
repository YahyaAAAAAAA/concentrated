import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@injectable
class ExtractQuestionsFromPDF {
  final ExamRepository repository;

  ExtractQuestionsFromPDF(this.repository);

  Future<Either<Failure, List<Question>>> call(String pdfPath) async {
    return await repository.extractQuestionsFromPDF(pdfPath);
  }
}
