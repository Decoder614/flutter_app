# Architecture Rules — `data/`

If a dev breaks this → **PR rejected**

---

## `data/`
`data/` is the **implementation layer**.
It answers **how** data is fetched, stored, and transformed — never **what** the app does.

```text
features/<feature_name>/data/
├── datasources/
├── models/
└── repositories/
```

---

## NON-NEGOTIABLE RULES
- MAY use Supabase / HTTP / local storage
- MAY use `try/catch`
- MUST translate infra errors
- MUST implement domain repositories
- MUST NOT expose infra details upward
- 🚫 No UI
- 🚫 No Bloc
- 🚫 No routing
- 🚫 No feature-to-feature imports

---

## 1. Datasources (`datasources/`)
### Purpose
Lowest-level access to **external systems**.
**Examples:** Supabase, REST APIs, Local DB / cache.

### Rules
- Talks directly to infra.
- Returns raw models or primitives.
- Throws **only low-level exceptions**.
- No domain entities.
- No Failures.

### Allowed
- SupabaseClient
- Dio / HTTP
- SQL / storage APIs
- `try/catch`

### Not Allowed
- Bloc imports
- Domain entities
- UI logic
- Business decisions

### Example
```dart
class AuthRemoteDatasource {
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user!.toJson();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
```

---

## 2. Models (`models/`)
### Purpose
Translate **external data formats** into **domain-friendly shapes**.

### Rules
- Convert JSON / API responses.
- Contain mapping logic only.
- Convert to domain entities.
- No business logic.

### Allowed
- `fromJson`
- `toEntity`
- Parsing helpers

### Not Allowed
- Supabase calls
- Repositories
- Use cases
- Bloc imports

### Example
```dart
class UserModel {
  final String id;
  final String role;

  const UserModel({
    required this.id,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      role: UserRole.fromString(role),
    );
  }
}
```

---

## 3. Repositories (`repositories/`)
### Purpose
Bridge between **domain contracts** and **datasources**.
This is where:
- Infra errors are translated.
- Models become entities.
- Failures are thrown.

### Rules
- Implements domain repository interface.
- Catches infra exceptions.
- Throws **typed Failure only**.
- No UI or Bloc logic.

### Allowed
- `try/catch`
- Failure throwing
- Multiple datasources

### Not Allowed
- Returning infra models
- Throwing raw exceptions
- Feature logic

### Example
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> login(
    String email,
    String password,
  ) async {
    try {
      final json = await remote.login(email, password);
      return UserModel.fromJson(json).toEntity();
    } on DioException {
      throw const NetworkFailure();
    } on UnauthorizedException {
      throw const UnauthorizedFailure();
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
```

---

## 4. Error Translation (CRITICAL)
### Rule
**Infra errors stop here.**
1. Datasource throws infra exceptions.
2. Repository catches them.
3. Repository throws `Failure`.

**Allowed flow:**
`DioException` → `NetworkFailure` → `Bloc`

**Forbidden flow:**
`DioException` → `Bloc` ❌

---

## `data/` ENFORCEMENT CHECKLIST
Use this in every PR:

```text
data/
[ ] Datasources talk to infra only
[ ] Models only map data
[ ] Repositories translate errors
[ ] Only Failure leaves repository
[ ] No UI / Bloc imports
[ ] No domain logic
```
If any rule fails → ❌ PR rejected

---

## WHY `data/` IS STRICT
- Prevents infra leakage.
- Enables backend swaps.
- Enables mocking.
- Keeps Bloc simple.
- Centralizes error handling.

If `data/` stays clean → the rest stays clean.

---

## SUMMARY

### `data/` IS:
- Infrastructure boundary
- Error translation layer
- Implementation detail
- Replaceable

### `data/` IS NOT:
- Business logic
- UI logic
- State management
- App logic

---

## FINAL RULE (MOST IMPORTANT)
**If a Supabase / HTTP type appears outside `data/` — the architecture is broken.**
