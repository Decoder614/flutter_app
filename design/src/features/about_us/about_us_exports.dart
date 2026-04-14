/// The Public API for the `about_us` feature.
/// 
/// EXPORTS RULE:
/// The Router (`app/router/app_router.dart`) is ONLY allowed to import THIS file.
/// It must absolutely never deep import `presentation/pages/about_us_page.dart`.

export 'presentation/pages/about_us_page.dart';

// Note: We deliberately DO NOT export `team_member_card.dart`. 
// The rest of the app has no business knowing what a Team Member Card is.
