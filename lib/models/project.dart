import 'package:flutter/material.dart';

class Project {

  final String id;
  final String name;
  final String description;
  final String userId;
  final Color color; // === AJOUT PARTIE 5 ===
  final DateTime createdAt;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.color, // === AJOUT ===
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? userId,
    Color? color, // === AJOUT ===
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      color: color ?? this.color, // === AJOUT ===
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'color': color.value, // === AJOUT ===
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      userId: map['userId'],
      color: Color(map['color']), // === AJOUT ===
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}