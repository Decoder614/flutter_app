import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'blocs/example_bloc.dart';
// import 'blocs/example_event.dart';
// import 'blocs/example_state.dart';

import 'package:location_app/shared/loaders/initial_loader.dart';
import 'package:location_app/shared/screens/error_screen.dart';
import 'package:location_app/shared/buttons/primary_button.dart';

import '../widgets/example_loaded_widget.dart';

/// Top-level screen. 
/// Connects UI to Bloc, handles side effects, NEVER navigates manually.
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Feature')),
      body: const Center(
        // Uncomment when flutter_bloc is added
        /*
        child: BlocConsumer<ExampleBloc, ExampleState>(
          listener: (context, state) {
            // Handle side effects (Snackbars) strictly in the listener
            if (state is ExampleError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            // Dumb UI Rendering based purely on matched State
            if (state is ExampleInitial) {
              return PrimaryButton(
                text: 'Load Message',
                width: 200,
                onPressed: () {
                  context.read<ExampleBloc>().add(FetchExampleMessageRequested());
                },
              );
            } else if (state is ExampleLoading) {
              return const InitialLoader();
            } else if (state is ExampleLoaded) {
              return ExampleLoadedWidget(entity: state.data);
            } else if (state is ExampleError) {
              return ErrorScreen(
                message: state.message,
                onRetry: () {
                  context.read<ExampleBloc>().add(FetchExampleMessageRequested());
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
        */
        child: Text('Example Feature UI (Uncomment BlocConsumer when ready)'),
      ),
    );
  }
}
