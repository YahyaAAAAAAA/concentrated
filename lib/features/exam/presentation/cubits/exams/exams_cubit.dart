import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/get_exams_by_subject.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exams/exams_states.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_states.dart';

@injectable
class ExamsCubit extends Cubit<ExamsStates> {
  final GetExamsBySubject getExams;
  String? _lastGrade;
  String? _lastSubject;

  ExamsCubit(this.getExams) : super(ExamsInitial());

  Future<void> getExamsBySubject(String grade, String subject) async {
    if (_lastGrade == grade &&
        _lastSubject == subject &&
        state is SubjectsLoaded) {
      return;
    }
    _lastGrade = grade;
    _lastSubject = subject;

    emit(ExamsLoading());

    final result = await getExams(grade, subject);
    result.fold(
      (failure) {
        if (!isClosed) emit(ExamsError(failure.message));
      },
      (subjects) {
        if (!isClosed) emit(ExamsLoaded(subjects));
      },
    );
  }
}
