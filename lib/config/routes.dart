import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/home_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/exam_editor_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/subjects_viewer_page.dart';

class AppPage {
  final String path;
  final String name;

  const AppPage(this.path, this.name);
}

//short for app page routes
class APR {
  static const home = AppPage('/', 'home');
  static const editor = AppPage('/editor', 'editor');
  static const subjects = AppPage('/subjects/:grade', 'subjects');
}

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
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
    ],
  );
}
