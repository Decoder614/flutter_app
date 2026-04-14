import 'package:location_app/core/usecase/usecase.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repository.dart';

/// Represents one business action: Fetching the example message.
/// STRICT RULES: Thin, boring, delegates to repository, no try/catch.
class GetExampleMessageUseCase implements UseCase<ExampleEntity, NoParams> {
  final ExampleRepository repository;

  GetExampleMessageUseCase(this.repository);

  @override
  Future<ExampleEntity> call(NoParams params) {
    return repository.getExampleMessage();
  }
}
