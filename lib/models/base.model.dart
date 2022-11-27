///
abstract class BaseModel {
  ///
  BaseModel();

  ///
  DateTime? updatedAt;

  ///
  DateTime? createdAt;

  ///
  String? key;

  ///
  Map<String, dynamic> toJson();

  ///
  BaseModel fromJson(Map<String, dynamic> json);
}
