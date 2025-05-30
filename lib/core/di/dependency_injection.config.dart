// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tweleve_ace/core/di/injectable_modules.dart' as _i450;
import 'package:tweleve_ace/features/exam/data/datasources/exam_remote_datasource.dart'
    as _i582;
import 'package:tweleve_ace/features/exam/data/repositories_impl/exam_repo_impl.dart'
    as _i845;
import 'package:tweleve_ace/features/exam/domain/repositories/exam_repo.dart'
    as _i754;
import 'package:tweleve_ace/features/exam/domain/usecases/extract_questions_from_pdf.dart'
    as _i862;
import 'package:tweleve_ace/features/exam/domain/usecases/upload_questions.dart'
    as _i912;
import 'package:tweleve_ace/features/exam/presentation/cubits/exam_cubit.dart'
    as _i1050;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final httpClientModule = _$HttpClientModule();
    final firestoreModule = _$FirestoreModule();
    gh.lazySingleton<_i519.Client>(() => httpClientModule.client);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firestoreModule.firestore);
    gh.factory<_i582.ExamRemoteDataSource>(
        () => _i582.ExamRemoteDataSource(gh<_i519.Client>()));
    gh.lazySingleton<_i754.ExamRepository>(() => _i845.ExamRepositoryImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i582.ExamRemoteDataSource>(),
        ));
    gh.factory<_i862.ExtractQuestionsFromPDF>(
        () => _i862.ExtractQuestionsFromPDF(gh<_i754.ExamRepository>()));
    gh.factory<_i912.UploadQuestions>(
        () => _i912.UploadQuestions(gh<_i754.ExamRepository>()));
    gh.factory<_i1050.ExamCubit>(() => _i1050.ExamCubit(
          gh<_i862.ExtractQuestionsFromPDF>(),
          gh<_i912.UploadQuestions>(),
        ));
    return this;
  }
}

class _$HttpClientModule extends _i450.HttpClientModule {}

class _$FirestoreModule extends _i450.FirestoreModule {}
