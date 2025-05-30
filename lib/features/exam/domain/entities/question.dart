//todo should be immutable,create mutable method for viewModel
class Question {
  String question;
  List<String> options;
  int answer;

  Question({
    required this.question,
    required this.options,
    this.answer = 0,
  });
}
