import 'package:location_app/core/errors/exceptions.dart';
import 'package:location_app/core/errors/failures.dart';
import '../domain/entities/example_entity.dart';
import '../domain/repositories/example_repository.dart';
import 'datasources/example_remote_datasource.dart';
import 'models/example_model.dart';

/// Bridge between domain contracts and datasources.
/// STRICT RULES: Translates infra errors into Typed Failures ONLY.
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDatasource remote;

  ExampleRepositoryImpl(this.remote);

  @override
  Future<ExampleEntity> getExampleMessage() async {
    try {
      final json = await remote.fetchMessage();
      return ExampleModel.fromJson(json).toEntity(); // Format conversion
    } on ServerException catch (e) {
      // Translate known infra exception to Failure
      throw ServerFailure(e.message);
    } catch (e) {
      // Catch anything else and translate to an UnknownFailure
      throw const UnknownFailure();
    }
  }
}
