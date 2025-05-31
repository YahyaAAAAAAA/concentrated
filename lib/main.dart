import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tweleve_ace/config/routes.dart';
import 'package:tweleve_ace/core/bloc/blocs_provider.dart';
import 'package:tweleve_ace/core/di/dependency_injection.dart';
import 'package:tweleve_ace/core/theme/app_theme.dart';
import 'package:tweleve_ace/firebase_options.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //di
  await configureDependencies();

  //set orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocsProvider(
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: appTheme(),
          // home: HomePage(),
        ),
      ),
    );
  }
}
