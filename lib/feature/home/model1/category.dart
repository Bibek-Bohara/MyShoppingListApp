class Category {
  Category({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.picture,
  });

  final int id;
  final String name;
  final String description;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic picture;

  Category copyWith({
    int id,
    String name,
    String description,
    int createdBy,
    int updatedBy,
    DateTime createdAt,
    DateTime updatedAt,
    dynamic picture,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        picture: picture ?? this.picture,
      );

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "picture": picture,
      };
}