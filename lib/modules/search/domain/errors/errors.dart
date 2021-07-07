abstract class FailureSearch implements Exception {}

class InvalidTextError extends FailureSearch {}

class DatasourceError extends FailureSearch {
  final String message;

  DatasourceError({this.message});
}
