// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:location_app/core/errors/failures.dart';
// import 'package:location_app/core/usecase/usecase.dart';
// import '../../domain/usecases/get_example_message_usecase.dart';
// import 'example_event.dart';
// import 'example_state.dart';

/// Coordinates user intent -> domain actions -> UI state.
/// STRICT RULES: NEVER navigates. Catches ONLY `Failure`.
/// (Inheritance commented out until flutter_bloc is installed)

/*
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final GetExampleMessageUseCase getExampleMessageUseCase;

  ExampleBloc({required this.getExampleMessageUseCase}) : super(ExampleInitial()) {
    on<FetchExampleMessageRequested>((event, emit) async {
      emit(ExampleLoading());

      try {
        final entity = await getExampleMessageUseCase(const NoParams());
        emit(ExampleLoaded(entity));
      } on Failure catch (failure) {
        emit(ExampleError(failure.message));
      }
    });
  }
}
*/
