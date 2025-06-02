import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tweleve_ace/core/error/failures.dart';
import 'package:tweleve_ace/core/utils/logger.dart';
import 'package:tweleve_ace/features/exam/data/datasources/exam_remote_datasource.dart';
import 'package:tweleve_ace/features/exam/data/models/question_model.dart';
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

  //todo should be moved
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

      Logger.info('${entities.length} questions extracted');
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //todo should specify category (school,uni) or separate methods
  @override
  Future<Either<Failure, List<String>>> getSubjectsByGrade(String grade) async {
    try {
      final gradeSnapshot =
          await _firestore.collection('school').doc(grade).get();

      final data = gradeSnapshot.data();
      if (data == null || !data.containsKey('subjects')) {
        return Left(UnexpectedFailure('No subjects found for this grade'));
      }
      Logger.info(
          '${List.from(data['subjects']).length} subjects from $grade loaded');

      return Right(List.from(data['subjects']));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getExamsBySubject(
      String grade, String subject) async {
    try {
      final examsSnapshot = await _firestore
          .collection('school')
          .doc(grade)
          .collection(subject)
          .get();

      final exams = examsSnapshot.docs.map((doc) => doc.id).toList();

      Logger.info('${exams.length} exams from $grade/$subject loaded');
      return Right(exams);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestionsByExam(
      String grade, String subject, String exam) async {
    try {
      final questionsSnapshot = await _firestore
          .collection('school')
          .doc(grade)
          .collection(subject)
          .doc(exam)
          .get();

      var questionsData = questionsSnapshot.data();
      if (questionsData == null) {
        Logger.debug('null');
      }

      final questionsList = (questionsData!['questions'] as List)
          .map((q) =>
              QuestionModel.fromJson(Map<String, dynamic>.from(q)).toEntity())
          .toList();

      Logger.info(
          '${questionsList.length} questions from $grade/$subject/$exam loaded');
      return Right(questionsList);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  //todo should be moved
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

      Logger.info(
          '(${path.exam}) with ${questions.length} questions uploaded to ${path.category}/${path.grade}/${path.subject}');
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
