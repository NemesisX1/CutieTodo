///
abstract class Strategy {
  ///
  const Strategy();

  ///
  Future<dynamic> validate(Map<String, String> headers);
}
