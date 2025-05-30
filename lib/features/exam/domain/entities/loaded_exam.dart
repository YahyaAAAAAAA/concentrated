import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/domain/entities/school_exam_path.dart';

class LoadedExam {
  final SchoolExamPath path;
  final List<Question> questions;

  LoadedExam({required this.path, required this.questions});
}
