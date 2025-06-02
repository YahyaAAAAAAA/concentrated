import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/features/exam/domain/entities/question.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/answers_viewer_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/exams_viewer_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/home_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/exam_editor_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/questions_viewer_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/subjects_viewer_page.dart';

class AppPage {
  final String path;
  final String name;

  const AppPage(this.path, this.name);
}

//app page routes
class APR {
  static const home = AppPage('/', 'home');
  static const editor = AppPage('/editor', 'editor');
  static const subjects = AppPage('/subjects/:grade', 'subjects');
  static const exams = AppPage('/subjects/:grade/:subject', 'exams');
  static const questions =
      AppPage('/subjects/:grade/:subject/:exam', 'questions');
  static const answers =
      AppPage('/subjects/:grade/:subject/:exam/answers', 'answers');
}

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: APR.home.path,
    routes: [
      GoRoute(
        path: APR.home.path,
        name: APR.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: APR.editor.path,
        name: APR.editor.name,
        builder: (context, state) => const ExamEditorPage(),
      ),
      GoRoute(
        path: APR.subjects.path,
        name: APR.subjects.name,
        builder: (context, state) =>
            SubjectsViewerPage(grade: state.pathParameters['grade'] ?? '12.1'),
      ),
      GoRoute(
        path: APR.exams.path,
        name: APR.exams.name,
        builder: (context, state) => ExamsViewerPage(
          grade: state.pathParameters['grade'] ?? '12.1',
          subject: state.pathParameters['subject'] ?? 'english',
        ),
      ),
      GoRoute(
        path: APR.questions.path,
        name: APR.questions.name,
        builder: (context, state) => QuestionsViewerPage(
          grade: state.pathParameters['grade'] ?? '12.1',
          subject: state.pathParameters['subject'] ?? 'english',
          exam: state.pathParameters['exam'] ?? 'R2024',
        ),
      ),
      GoRoute(
        path: APR.answers.path,
        name: APR.answers.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final questions = extra?['questions'] as List<Question>? ?? [];
          final answers = extra?['answers'] as List<int?>? ?? [];
          return AnswersViewerPage(
            grade: state.pathParameters['grade'] ?? '12.1',
            subject: state.pathParameters['subject'] ?? 'english',
            exam: state.pathParameters['exam'] ?? 'R2024',
            answers: answers,
            questions: questions,
          );
        },
      ),
    ],
  );
}
