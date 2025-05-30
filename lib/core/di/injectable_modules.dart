import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@module
abstract class HttpClientModule {
  @lazySingleton
  http.Client get client => http.Client();
}

@module
abstract class FirestoreModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
