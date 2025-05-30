import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/features/exam/data/datasources/exam_remote_datasource.dart';
import 'package:tweleve_ace/features/exam/data/models/question_model.dart';
import 'package:tweleve_ace/features/exam/domain/entities/loaded_exam.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart';

@LazySingleton(as: ExamRepository)
class ExamRepositoryImpl implements ExamRepository {
  final FirebaseFirestore _firestore;
  final ExamRemoteDataSource _remoteDataSource;

  ExamRepositoryImpl(
    this._firestore,
    this._remoteDataSource,
  );

  @override
  Future<Either<Failure, List<Question>>> extractQuestionsFromPDF(
      String pdfPath) async {
    try {
      final models = await _remoteDataSource.applyOCR(pdfPath);
      final entities = models
          .map((m) => Question(
                question: m.question,
                options: m.options,
                answer: m.answer,
              ))
          .toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LoadedExam>>> getExamsByGrade(
      String grade) async {
    try {
      final subjects = [
        'arabic',
        'english',
        'religion',
        'history',
        'computer',
      ];

      List<LoadedExam> exams = [];

      for (final subject in subjects) {
        final doc = await _firestore
            .collection('school')
            .doc(grade)
            .collection(subject)
            .doc('R2024')
            .get();

        if (doc.exists) {
          final data = doc.data();
          if (data != null && data['questions'] != null) {
            final questionsJson =
                List<Map<String, dynamic>>.from(data['questions']);
            final questions = questionsJson
                .map((json) => QuestionModel.fromJson(json).toEntity())
                .toList();

            exams.add(
              LoadedExam(
                path: SchoolExamPath(
                  category: 'school',
                  grade: grade,
                  subject: subject,
                  exam: 'R2024',
                ),
                questions: questions,
              ),
            );
          }
        }
      }

      return Right(exams);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadQuestions(
    List<Question> questions,
    SchoolExamPath path,
  ) async {
    try {
      final qs =
          questions.map((q) => QuestionModel.fromEntity(q).toJson()).toList();

      await _firestore
          .collection(path.category)
          .doc(path.grade)
          .collection(path.subject)
          .doc(path.exam)
          .set({'questions': qs});

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
