import '../domain/entities/example_entity.dart';

/// Translates external data formats into domain-friendly shapes.
/// STRICT RULES: Mapping logic only, no business logic, no repository calls.
class ExampleModel {
  final String id;
  final String text;
  final String timestamp;

  const ExampleModel({
    required this.id,
    required this.text,
    required this.timestamp,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'] as String,
      text: json['text'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  /// Converts the infra model to a purely typed domain entity.
  ExampleEntity toEntity() {
    return ExampleEntity(
      id: id,
      message: text,
      createdAt: DateTime.parse(timestamp),
    );
  }
}
