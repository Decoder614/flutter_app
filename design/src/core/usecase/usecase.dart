/// Defines the **application action contract**.
/// A use case represents **one intention** (e.g., "User wants to log in").
/// 
/// Type [Type] is the return type (A Domain Entity or void).
/// Type [Params] is the parameter payload needed to execute the use case.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// A synchronous use case (for specific synchronous logic requirements)
abstract class SyncUseCase<Type, Params> {
  Type call(Params params);
}

/// Use this class when a use case requires absolutely zero parameters.
/// (e.g., fetching a static list of countries that doesn't need filters)
class NoParams {
  const NoParams();
}
