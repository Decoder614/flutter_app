/// Abstracts **connectivity awareness**.
/// Enables offline handling, predictable failures, and unit testability.
/// NEVER directly check connectivity inside a Bloc or a UI Widget.
abstract class NetworkInfo {
  /// Returns [true] if the device is currently connected to the internet.
  Future<bool> get isConnected;
}

// In a real implementation, you would write this using a tool like
// `internet_connection_checker_plus` inside a separate Implementation file.

/*
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
*/
