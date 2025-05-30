import 'package:tweleve_ace/features/exam/domain/entities/loaded_exam.dart';

abstract class ExamViewerState {}

class ExamViewerInitial extends ExamViewerState {}

class ExamViewerLoading extends ExamViewerState {}

class ExamViewerLoaded extends ExamViewerState {
  final List<LoadedExam> exams;
  ExamViewerLoaded(this.exams);
}

class ExamViewerError extends ExamViewerState {
  final String message;
  ExamViewerError(this.message);
}
