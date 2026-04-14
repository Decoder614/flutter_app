// import 'package:get_it/get_it.dart';

// final getIt = GetIt.instance;

/// The **ONLY** place where dependencies are wired in the entire application.
/// If a dependency is not registered here, it does not exist.
Future<void> configureDependencies() async {
  /*
  // === CORE INFRASTRUCTURE ===
  // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  // getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  // getIt.registerLazySingleton<Dio>(() => DioContainer.createDio());

  // ==========================================
  // === FEATURES: AUTHENTICATION ===
  // ==========================================

  // 1. Data Sources (Talks directly to infra)
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(client: getIt<SupabaseClient>()),
  );

  // 2. Repositories (Translates errors, implements domain contract)
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: getIt<AuthRemoteDatasource>()),
  );

  // 3. Use Cases (1 intention per class)
  getIt.registerLazySingleton(() => LoginUseCase(repository: getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(repository: getIt<AuthRepository>()));

  // 4. Blocs (Global or Feature level)
  getIt.registerFactory(() => AuthBloc(
    loginUseCase: getIt<LoginUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
  ));
  */
}
