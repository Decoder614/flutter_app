/// Example of a Global App-Wide Bloc.
/// Notice how this lives in `app/blocs/` because MULTIPLE features need to know
/// if the user is authenticated (e.g., the Router needs it for guards, Profile needs it).
/// 
/// If this was a "Feature-Specific" Bloc (like `ShoppingCartBloc`), it would live
/// in `features/shopping_cart/presentation/blocs/` instead.

/*
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:location_app/core/error/failures.dart';
// import 'package:location_app/features/auth/domain/entities/user_entity.dart';
// import 'package:location_app/features/auth/domain/usecases/logout_usecase.dart';

// --- EVENTS ---
abstract class AuthEvent {}
class AuthLogoutRequested extends AuthEvent {}
class AuthStatusChanged extends AuthEvent {
  final UserEntity? user;
  AuthStatusChanged(this.user);
}

// --- STATES ---
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {}

// --- BLOC ---
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final LogoutUseCase _logoutUseCase;

  AuthBloc() : super(AuthInitial()) {
    
    // React to status changes (like from a Supabase auth state listener)
    on<AuthStatusChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthAuthenticated(event.user!));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Handle logout use case
    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      
      // await _logoutUseCase(NoParams());
      
      emit(AuthUnauthenticated());
      // NOTE: We do NOT call `context.go('/login')` here!
      // The router will automatically detect `AuthUnauthenticated` 
      // via the redirect logic and navigate internally!
    });
  }
}
*/
