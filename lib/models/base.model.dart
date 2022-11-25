///
abstract class Model {
  ///
  Model();

  ///
  factory Model.fromJson() {
    throw UnimplementedError();
  }

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
