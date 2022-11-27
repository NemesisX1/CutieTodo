abstract class Strategy {
  Future<void> authorize(Map<String, dynamic> headers);
}
