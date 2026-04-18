class RepositoryException implements Exception {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  RepositoryException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() {
    final causeStr = cause != null ? ' Cause: $cause' : '';
    return 'RepositoryException: $message$causeStr';
  }
}
