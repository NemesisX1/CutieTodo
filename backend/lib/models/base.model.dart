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
  BaseModel updateFromJson(Map<String, dynamic> json) {
    final thisJson = toJson();

    json.forEach((key, value) {
      if (value != null) thisJson[key] = value;
    });
    return fromJson(thisJson);
  }

  ///
  BaseModel fromJson(Map<String, dynamic> json);
}
