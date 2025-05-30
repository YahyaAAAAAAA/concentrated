import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/data/models/question_model.dart';

@injectable
class ExamRemoteDataSource {
  final http.Client client;

  ExamRemoteDataSource(this.client);

  Future<List<QuestionModel>> applyOCR(String pdfPath) async {
    final response = await client.get(
      Uri.parse('http://localhost:3000/questions?pdfPath=$pdfPath'),
    );
    final List data = jsonDecode(response.body);

    return data
        .map(
          (q) => QuestionModel(
            question: q['question'],
            options: List<String>.from(q['options']),
          ),
        )
        .toList();
  }
}
