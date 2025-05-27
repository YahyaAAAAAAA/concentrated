import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tweleve_ace/core/theme/app_theme.dart';
import 'package:tweleve_ace/data/datasources/exam_remote_datasource.dart';
import 'package:tweleve_ace/data/repositories_impl/exam_repo_impl.dart';
import 'package:tweleve_ace/domain/usecases/extract_questions_from_pdf.dart';
import 'package:tweleve_ace/domain/usecases/upload_questions.dart';
import 'package:tweleve_ace/firebase_options.dart';
import 'package:tweleve_ace/presentation/cubits/exam_cubit.dart';
import 'package:tweleve_ace/presentation/pages/home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: '.env');

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    //set orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    //todo fix shouldn't be here
    final examRepo = ExamRepositoryImpl(ExamRemoteDataSource(http.Client()));
    final getQuestionsUseCase = ExtractQuestionsFromPDF(examRepo);
    final uploadQuestions = UploadQuestions(examRepo);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ExamCubit(getQuestionsUseCase, uploadQuestions),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: const HomePage()),
      ),
    );
  }
}
