/// Central place for **non-environment constants**.
/// NO magic numbers, NO API keys, NO feature-specific values.
class AppConstants {
  const AppConstants._(); // Private constructor prevents instantiation

  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int maxRetryCount = 3;
  static const String appName = 'Location App';
  static const int paginationLimit = 20;
}
