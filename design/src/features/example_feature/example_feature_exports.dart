/// The Public API for the `example_feature`.
/// 
/// EXPORTS RULE:
/// The Router (`app/router/app_router.dart`) is ONLY allowed to import THIS file.
/// No deep imports into presentation files are permitted.

export 'presentation/pages/example_page.dart';

// Note: We deliberately DO NOT export our Blocs, UseCases, or Repositories.
// Those are wired up inside `app/di/injection.dart` and nowhere else.
