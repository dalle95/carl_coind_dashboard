class CARLException implements Exception {
  final String message;

  CARLException(this.message);

  @override
  String toString() {
    return message;
  }
}
