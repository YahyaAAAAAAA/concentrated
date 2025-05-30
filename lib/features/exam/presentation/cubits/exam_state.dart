import 'package:tweleve_ace/features/exam/domain/entities/question.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamExtracted extends ExamState {
  final List<Question> questions;
  ExamExtracted(this.questions);
}

class ExamUploaded extends ExamState {}

class ExamError extends ExamState {
  final String message;
  ExamError(this.message);
}
