abstract class SubjectsStates {}

class SubjectsInitial extends SubjectsStates {}

class SubjectsLoading extends SubjectsStates {}

class SubjectsLoaded extends SubjectsStates {
  final List<String> subjects;

  SubjectsLoaded(this.subjects);
}

class SubjectsError extends SubjectsStates {
  final String message;
  SubjectsError(this.message);
}
