import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/get_exams_by_grade.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/viewer/exam_viewer_states.dart';

@injectable
class ExamViewerCubit extends Cubit<ExamViewerState> {
  final GetExamsByGrade getExams;

  ExamViewerCubit(this.getExams) : super(ExamViewerInitial());

  Future<void> loadSubjects() async {
    emit(ExamViewerLoading());

    final result = await getExams('12.1');
    result.fold(
      (failure) => emit(ExamViewerError(failure.message)),
      (exams) => emit(ExamViewerLoaded(exams)),
    );
  }
}
