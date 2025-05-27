class QuestionUtils {
  static List<String> cleanOptions(String raw) {
    // Matches A) ... B) ..., even if no space, or B. etc.
    final regex = RegExp(r"(?<=[A-D][)\.])\s*[^A-D]+(?=(?:[A-D][)\.]|$))");

    final matches = regex.allMatches(raw);

    return matches.map((match) => match.group(0)!.trim()).toList();
  }
}
