///
abstract class Model {
  ///
  DateTime? updatedAt;

  ///
  DateTime? createdAt;

  ///
  String? key;

  ///
  Map<String, dynamic> toJson();

  ///
  Model fromJson(Map<String, dynamic> json);
}
