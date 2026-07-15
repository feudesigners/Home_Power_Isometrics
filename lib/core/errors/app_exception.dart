class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppException: $message';
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.cause});
}

class PersistenceException extends AppException {
  const PersistenceException(super.message, {super.cause});
}
