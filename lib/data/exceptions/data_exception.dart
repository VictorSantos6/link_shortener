class DataSourceException implements Exception {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  DataSourceException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() {
    final causeStr = cause != null ? ' Cause: $cause' : '';
    return 'DataSourceException: $message$causeStr';
  }
}
