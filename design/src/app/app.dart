import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'blocs/auth_bloc.dart';
// import 'di/injection.dart';
// import 'package:location_app/shared/theme/app_theme.dart';

// import 'router/app_router.dart';

/// The Root Application Shell.
/// Responsible strictly for routing, global theming, and multi-providers.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real application, you would wrap `_AppView` with a `MultiBlocProvider`
    // to provide GLOBAL blocs (like AuthBloc, ThemeBloc) to the entire router tree.
    /*
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        // BlocProvider<ThemeBloc>(create: (_) => getIt<ThemeBloc>()),
      ],
      child: const _AppView(),
    );
    */
    return const _AppView();
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    // Example: Reacting to a ThemeBloc to switch dark/light mode dynamically
    // final themeMode = context.select((ThemeBloc bloc) => bloc.state.themeMode);

    return MaterialApp(
      title: 'Location App',
      // If we configured go_router, we would use MaterialApp.router here:
      // routerConfig: appRouter,
      
      // Global Theme Configs (Belongs in shared/theme/)
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeMode,
      
      // Add global behaviors (e.g., dismissing keyboard on tap)
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child!,
        );
      },
      home: const Scaffold(
        body: Center(
          child: Text('App Initialized Successfully (Feature-First Architecture)'),
        ),
      ),
    );
  }
}
