///
abstract class Strategy {
  ///
  const Strategy();

  ///
  Future<bool> authorize(Map<String, dynamic> headers);
}
