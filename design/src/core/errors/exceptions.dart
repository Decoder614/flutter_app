/// Represents low-level technical problems (API, cache, auth, etc.)
/// Used ONLY inside the data layer `try/catch` blocks.
/// DO NOT use inside Domain or Presentation!
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Code: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Failed to process cached data.']);
  
  @override
  String toString() => 'CacheException: $message';
}

class UnauthorizedException implements Exception {
  const UnauthorizedException();
}
