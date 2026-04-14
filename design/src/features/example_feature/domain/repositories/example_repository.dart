import 'example_entity.dart';

/// Defines what data the domain needs, not where it comes from.
/// STRICT RULES: Interfaces only. No exceptions defined here.
abstract class ExampleRepository {
  /// Fetches the example message.
  /// Throws [Failure] subclass if an error occurs.
  Future<ExampleEntity> getExampleMessage();
}
