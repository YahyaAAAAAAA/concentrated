import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tweleve_ace/features/exam/domain/usecases/get_questions_by_exam.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/questions/questions_states.dart';

@injectable
class QuestionsCubit extends Cubit<QuestionsStates> {
  final GetQuestionsByExam getQuestions;

  QuestionsCubit(this.getQuestions) : super(QuestionsInitial());

  Future<void> getQuestionsByExam(
      String grade, String subject, String exam) async {
    emit(QuestionsLoading());

    final result = await getQuestions(grade, subject, exam);
    result.fold(
      (failure) {
        if (!isClosed) emit(QuestionsError(failure.message));
      },
      (subjects) {
        if (!isClosed) emit(QuestionsLoaded(subjects));
      },
    );
  }
}
