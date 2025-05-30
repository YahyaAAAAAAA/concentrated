import 'package:tweleve_ace/features/exam/domain/entities/question.dart';

class QuestionModel {
  final String question;
  final List<String> options;
  final int answer;

  QuestionModel({
    required this.question,
    required this.options,
    this.answer = 0,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] as String,
      options: List<String>.from(json['options']),
      answer: json['answer'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  Question toEntity() {
    return Question(
      question: question,
      options: options,
      answer: answer,
    );
  }

  factory QuestionModel.fromEntity(Question question) {
    return QuestionModel(
      question: question.question,
      options: question.options,
      answer: question.answer,
    );
  }
}
