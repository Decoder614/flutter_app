// import 'package:equatable/equatable.dart';

/// Typed, UI-safe, catchable errors.
/// Can be thrown and caught. Can be safely shown to end users.
/// ONLY Failures are allowed to cross the boundary into the Bloc layer.
abstract class Failure /* extends Equatable */ {
  final String message;
  
  const Failure(this.message);

  // @override
  // List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'A server error occurred. Please try again later.',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'Failed to load local data.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection available.',
  ]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Your session has expired. Please log in again.',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'An unexpected error occurred.',
  ]);
}
