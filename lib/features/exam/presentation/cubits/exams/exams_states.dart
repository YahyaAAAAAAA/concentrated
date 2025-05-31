abstract class ExamsStates {}

class ExamsInitial extends ExamsStates {}

class ExamsLoading extends ExamsStates {}

class ExamsLoaded extends ExamsStates {
  final List<String> exams;

  ExamsLoaded(this.exams);
}

class ExamsError extends ExamsStates {
  final String message;
  ExamsError(this.message);
}
