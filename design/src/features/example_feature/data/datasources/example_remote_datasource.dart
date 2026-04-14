import 'package:location_app/core/errors/exceptions.dart';
// import 'package:dio/dio.dart';

/// Lowest-level access to external systems.
/// STRICT RULES: Returns raw models, throws ONLY low-level exceptions.
abstract class ExampleRemoteDatasource {
  Future<Map<String, dynamic>> fetchMessage();
}

class ExampleRemoteDatasourceImpl implements ExampleRemoteDatasource {
  // final Dio client;
  // ExampleRemoteDatasourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> fetchMessage() async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));
      
      // final response = await client.get('/example-endpoint');
      // return response.data;
      
      return {
        'id': '123',
        'text': 'Hello from Clean Architecture!',
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      // Catch DioException or other infra errors and throw ServerException
      throw ServerException(message: e.toString());
    }
  }
}
