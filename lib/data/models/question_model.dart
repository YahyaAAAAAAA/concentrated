import 'package:tweleve_ace/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.question,
    required super.options,
    super.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final question = json['question'] as String;
    final options = json['options'];
    final answer = json['answer'] ?? 0;

    return QuestionModel(question: question, options: options, answer: answer);
  }

  Map<String, dynamic> toJson() {
    return {'question': question, 'options': options, 'answer': answer};
  }
}
