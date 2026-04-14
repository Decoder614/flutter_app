import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';

import 'di/injection.dart';

/// Single entry point for application startup.
/// NO feature imports, NO async work beyond setup.
/// This prevents `main.dart` from becoming bloated.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // 1. Centralized Error Handling
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
    // TODO: Send errors to Crashlytics or Sentry here
  };

  // 2. Ensure Flutter bindings are initialized before calling async platform code
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize third-party SDKs
  // (We comment these out to prevent compilation errors until packages are added to pubspec)
  // await Supabase.initialize(url: 'YOUR_URL', anonKey: 'YOUR_KEY');
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // 4. Initialize Dependency Injection (get_it)
  await configureDependencies();

  // 5. Run the app
  runApp(await builder());
}
