import 'package:tweleve_ace/data/datasources/exam_remote_datasource.dart';
import 'package:tweleve_ace/data/models/question_model.dart';
import 'package:tweleve_ace/domain/entities/question.dart';
import 'package:tweleve_ace/domain/entities/school_exam_path.dart';
import 'package:tweleve_ace/domain/repositories/exam_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamRepositoryImpl implements ExamRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final ExamRemoteDataSource remoteDataSource;

  ExamRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Question>> extractQuestionsFromPDF(String pdfPath) async {
    final models = await remoteDataSource.applyOCR(pdfPath);
    return models
        .map(
          (model) => Question(question: model.question, options: model.options),
        )
        .toList();
  }

  @override
  Future<void> uploadQuestions(
    List<Question> questions,
    SchoolExamPath path,
  ) async {
    try {
      List<QuestionModel> qs =
          questions
              .map(
                (q) => QuestionModel(
                  question: q.question,
                  options: q.options,
                  answer: q.answer,
                ),
              )
              .toList();
      //school (col) -> grades (docs) -> subs (col) -> exams (doc) -> questions (col)
      firebaseFirestore
          .collection(path.category)
          .doc(path.grade)
          .collection(path.subject)
          .doc(path.exam)
          .set({'questions': qs.map((e) => e.toJson()).toList()});
    } catch (e) {
      throw Exception(e);
    }
  }
}
