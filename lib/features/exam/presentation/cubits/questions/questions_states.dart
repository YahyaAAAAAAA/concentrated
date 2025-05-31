import 'package:tweleve_ace/features/exam/domain/entities/question.dart';

abstract class QuestionsStates {}

class QuestionsInitial extends QuestionsStates {}

class QuestionsLoading extends QuestionsStates {}

class QuestionsLoaded extends QuestionsStates {
  final List<Question> questions;

  QuestionsLoaded(this.questions);
}

class QuestionsError extends QuestionsStates {
  final String message;
  QuestionsError(this.message);
}
