import 'package:dartz/dartz.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';

abstract class ExamRepository {
  Future<Either<Failure, List<Question>>> extractQuestionsFromPDF(
      String pdfPath);

  Future<Either<Failure, void>> uploadQuestions(
      List<Question> questions, SchoolExamPath path);

  Future<Either<Failure, List<Question>>> getQuestionsByExam(
      String grade, String subject, String exam);

  Future<Either<Failure, List<String>>> getSubjectsByGrade(String grade);

  Future<Either<Failure, List<String>>> getExamsBySubject(
      String grade, String subject);
}
