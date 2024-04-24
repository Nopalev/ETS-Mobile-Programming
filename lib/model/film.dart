const String tableName = 'film';

class FilmFields {
  static final List<String> values = [
    id, title, added, cover, description
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String added = 'added';
  static const String cover = 'cover';
  static const String description = 'description';
}

class Film{
  final int? id;
  final String title;
  final DateTime added;
  final String cover;
  final String description;

  const Film({
    this.id,
    required this.title,
    required this.added,
    required this.cover,
    required this.description
  });

  Map<String, Object?> toJson() {
    Map<String, Object?> json = {
      FilmFields.id : id,
      FilmFields.title: title,
      FilmFields.added: added.toIso8601String(),
      FilmFields.cover: cover,
      FilmFields.description: description
    };
    return json;
  }

  static Film fromJson(Map<String, Object?> json){
    return Film(
      id: json[FilmFields.id] as int?,
      title: json[FilmFields.title] as String,
      added: DateTime.parse(json[FilmFields.added] as String),
      cover: json[FilmFields.cover] as String,
      description: json[FilmFields.description] as String
    );
  }

  Film copy({
    int? id,
    String? title,
    DateTime? added,
    String? cover,
    String? description})
  {
    return Film(
      id: id ?? this.id,
      title: title ?? this.title,
      added: added ?? this.added,
      cover: cover ?? this.cover,
      description: description ?? this.description
    );
  }
}