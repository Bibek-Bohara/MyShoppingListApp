class Picture {
  Picture({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String alternativeText;
  final String caption;
  final int width;
  final int height;
  final Formats formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final dynamic previewUrl;
  final String provider;
  final dynamic providerMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Picture copyWith({
    int id,
    String name,
    String alternativeText,
    String caption,
    int width,
    int height,
    Formats formats,
    String hash,
    String ext,
    String mime,
    double size,
    String url,
    dynamic previewUrl,
    String provider,
    dynamic providerMetadata,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Picture(
        id: id ?? this.id,
        name: name ?? this.name,
        alternativeText: alternativeText ?? this.alternativeText,
        caption: caption ?? this.caption,
        width: width ?? this.width,
        height: height ?? this.height,
        formats: formats ?? this.formats,
        hash: hash ?? this.hash,
        ext: ext ?? this.ext,
        mime: mime ?? this.mime,
        size: size ?? this.size,
        url: url ?? this.url,
        previewUrl: previewUrl ?? this.previewUrl,
        provider: provider ?? this.provider,
        providerMetadata: providerMetadata ?? this.providerMetadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    id: json["id"],
    name: json["name"],
    alternativeText: json["alternativeText"],
    caption: json["caption"],
    width: json["width"],
    height: json["height"],
    formats: Formats.fromJson(json["formats"]),
    hash: json["hash"],
    ext: json["ext"],
    mime: json["mime"],
    size: json["size"].toDouble(),
    url: json["url"],
    previewUrl: json["previewUrl"],
    provider: json["provider"],
    providerMetadata: json["provider_metadata"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats.toJson(),
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
    "previewUrl": previewUrl,
    "provider": provider,
    "provider_metadata": providerMetadata,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Formats {
  Formats({
    this.thumbnail,
    this.large,
    this.small,
    this.medium,
  });

  final Thumbnail thumbnail;
  final Thumbnail large;
  final Thumbnail small;
  final Thumbnail medium;

  Formats copyWith({
    Thumbnail thumbnail,
    Thumbnail large,
    Thumbnail small,
    Thumbnail medium,
  }) =>
      Formats(
        thumbnail: thumbnail ?? this.thumbnail,
        large: large ?? this.large,
        small: small ?? this.small,
        medium: medium ?? this.medium,
      );

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    large: json["large"] == null ? null : Thumbnail.fromJson(json["large"]),
    small: json["small"] == null ? null : Thumbnail.fromJson(json["small"]),
    medium: json["medium"] == null ? null : Thumbnail.fromJson(json["medium"]),
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail.toJson(),
    "large": large == null ? null : large.toJson(),
    "small": small == null ? null : small.toJson(),
    "medium": medium == null ? null : medium.toJson(),
  };
}

class Thumbnail {
  Thumbnail({
    this.ext,
    this.url,
    this.hash,
    this.mime,
    this.name,
    this.path,
    this.size,
    this.width,
    this.height,
  });

  final String ext;
  final String url;
  final String hash;
  final String mime;
  final String name;
  final dynamic path;
  final double size;
  final int width;
  final int height;

  Thumbnail copyWith({
    String ext,
    String url,
    String hash,
    String mime,
    String name,
      path,
    double size,
    int width,
    int height,
  }) =>
      Thumbnail(
        ext: ext ?? this.ext,
        url: url ?? this.url,
        hash: hash ?? this.hash,
        mime: mime ?? this.mime,
        name: name ?? this.name,
        path: path ?? this.path,
        size: size ?? this.size,
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    ext: json["ext"],
    url: json["url"],
    hash: json["hash"].toString(),
    mime: json["mime"],
    name: json["name"],
    path: json["path"],
    size: json["size"].toDouble(),
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "ext": ext,
    "url": url,
    "hash": hash,
    "mime": mime,
    "name": name,
    "path": path,
    "size": size,
    "width": width,
    "height": height,
  };
}