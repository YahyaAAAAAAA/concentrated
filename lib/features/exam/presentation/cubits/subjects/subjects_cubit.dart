import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/get_subjects_by_grade.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/subjects/subjects_states.dart';

@injectable
class SubjectsCubit extends Cubit<SubjectsStates> {
  final GetSubjectsByGrade getSubjects;
  String? _lastGrade;

  SubjectsCubit(this.getSubjects) : super(SubjectsInitial());

  Future<void> getSubjectsByGrade(String grade) async {
    if (_lastGrade == grade && state is SubjectsLoaded) return;
    _lastGrade = grade;

    emit(SubjectsLoading());

    final result = await getSubjects(grade);
    result.fold(
      (failure) {
        if (!isClosed) emit(SubjectsError(failure.message));
      },
      (subjects) {
        if (!isClosed) emit(SubjectsLoaded(subjects));
      },
    );
  }
}
