class Profile {
  Profile({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.firstname,
    this.lastname,
    this.phone,
  });

  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final dynamic blocked;
  final Role role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstname;
  final String lastname;
  final dynamic phone;

  Profile copyWith({
    int id,
    String username,
    String email,
    String provider,
    bool confirmed,
    dynamic blocked,
    Role role,
    DateTime createdAt,
    DateTime updatedAt,
    String firstname,
    String lastname,
    dynamic phone,
  }) =>
      Profile(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        provider: provider ?? this.provider,
        confirmed: confirmed ?? this.confirmed,
        blocked: blocked ?? this.blocked,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    provider: json["provider"],
    confirmed: json["confirmed"],
    blocked: json["blocked"],
    role: Role.fromJson(json["role"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
  };
}

class Role {
  Role({
    this.id,
    this.name,
    this.description,
    this.type,
  });

  final int id;
  final String name;
  final String description;
  final String type;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
  };
}
