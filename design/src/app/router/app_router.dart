// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

/// Centralized navigation and access control using `go_router`.
/// 
/// RULES:
/// - Blocs NEVER navigate. UI NEVER calls Navigator directly.
/// - Router reacts to AuthBloc state (using a RouterRefreshNotifier).
/// - Enforces Authentication & RBAC (Role-Based Access Control) globally.

/*
final appRouter = GoRouter(
  initialLocation: '/',
  
  // A refreshNotifier that listens to AuthBloc state changes
  // refreshListenable: getIt<RouterRefreshStream>(...), 

  redirect: (context, state) {
    // ENFORCE RBAC & AUTH HERE
    // final authState = context.read<AuthBloc>().state;
    // final isAuthenticated = authState is AuthAuthenticated;
    // final isLoggingIn = state.matchedLocation == '/login';
    // 
    // If not logged in and not heading to login -> Redirect to login
    // if (!isAuthenticated && !isLoggingIn) return '/login';
    
    // If already logged in but heading to login -> Redirect to home
    // if (isAuthenticated && isLoggingIn) return '/';
    
    return null; // Let the route pass
  },
  
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Home Dashboard (Belongs in features/dashboard)')),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Login Screen (Belongs in features/auth)')),
      ),
    ),
  ],
  
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Route not found (Belongs in shared/screens/error_screen.dart)')),
  ),
);
*/
