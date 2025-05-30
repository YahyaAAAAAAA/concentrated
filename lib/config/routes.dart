import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tweleve_ace/core/di/dependency_injection.dart';
import 'package:tweleve_ace/features/exam/presentation/cubits/exam_cubit.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/home_page.dart';
import 'package:tweleve_ace/features/exam/presentation/pages/exam_editor_page.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<ExamCubit>(),
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: '/questions',
            name: 'questions',
            builder: (context, state) => BlocProvider(
                create: (context) => getIt<ExamCubit>(),
                child: const ExamEditorPage()),
          ),
        ],
      );
}
