/// Wrapper for third-party logging SDKs 
/// (e.g., Crashlytics, Sentry, or standard Dart developer log).
/// This prevents any feature from being directly coupled to the logging package.
abstract class LoggerService {
  void debug(String message);
  void info(String message);
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

// Example Implementation:
/*
import 'dart:developer' as dev;

class ConsoleLoggerServiceImpl implements LoggerService {
  @override
  void debug(String message) => dev.log('🐛 DEBUG: $message');

  @override
  void info(String message) => dev.log('💡 INFO: $message');

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log('🛑 ERROR: $message', error: error, stackTrace: stackTrace);
  }
}
*/
