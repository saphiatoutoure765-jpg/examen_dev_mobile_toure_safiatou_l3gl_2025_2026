class Project {

  final String id;
  final String name;
  final String description;
  final String userId;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? userId,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

}