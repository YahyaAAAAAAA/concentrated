import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweleve_ace/data/datasources/exam_remote_datasource.dart';
import 'package:tweleve_ace/data/repositories_impl/exam_repo_impl.dart';
import 'package:tweleve_ace/domain/usecases/extract_questions_from_pdf.dart';
import 'package:tweleve_ace/domain/usecases/upload_questions.dart';
import 'package:tweleve_ace/firebase_options.dart';
import 'package:tweleve_ace/presentation/cubits/exam_cubit.dart';
import 'package:tweleve_ace/presentation/pages/home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //todo later preserve splash screen
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        home: const HomePage(),
      ),
    );
  }
}
