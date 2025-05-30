abstract class Failure {
  final String message;

  Failure(this.message);
}

// For unexpected errors (fallback)
class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message);
}

// For server/API-related failures
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

// For Firestore or local DB errors
class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

// You can also define custom ones
class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
