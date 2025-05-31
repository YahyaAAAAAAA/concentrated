import 'package:tweleve_ace/core/utils/logger.dart';

abstract class Failure {
  final String message;
  final String? level;

  Failure(this.message, {this.level}) {
    Logger.failure(message, level);
  }
}

//for unexpected errors (fallback)
class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message, {super.level = 'UNEXPECTED'});
}

//for server/API-related failures
class ServerFailure extends Failure {
  ServerFailure(super.message, {super.level = 'SERVER'});
}

//for Firestore or local DB errors
class DatabaseFailure extends Failure {
  DatabaseFailure(super.message, {super.level = 'DATABASE'});
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message, {super.level = 'NETWORK'});
}
