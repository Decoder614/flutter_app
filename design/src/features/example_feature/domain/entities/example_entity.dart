/// Represents a core business object for the Example feature.
/// STRICT RULES: Immutable, no JSON parsing, no framework imports.
class ExampleEntity {
  final String id;
  final String message;
  final DateTime createdAt;

  const ExampleEntity({
    required this.id,
    required this.message,
    required this.createdAt,
  });
}
