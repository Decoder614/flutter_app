import '../../domain/entities/example_entity.dart';

/// Represents what the UI can render.
abstract class ExampleState {}

class ExampleInitial extends ExampleState {}

class ExampleLoading extends ExampleState {}

class ExampleLoaded extends ExampleState {
  final ExampleEntity data;
  ExampleLoaded(this.data);
}

class ExampleError extends ExampleState {
  final String message;
  ExampleError(this.message);
}
