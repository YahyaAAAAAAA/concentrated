//TODO make superclass for paths in general then specify for uni or school in repo impl
class SchoolExamPath {
  String category;
  String grade;
  String subject;
  String exam;

  SchoolExamPath({
    required this.category,
    required this.grade,
    required this.subject,
    required this.exam,
  });
}
