class Failure {
  final String message;

  @override
  String toString() {
    return 'Failure{message: $message}';
  }

  Failure([this.message = 'An unexpected error occurred']);
}