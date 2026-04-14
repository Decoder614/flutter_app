# Architecture Rules — `domain/`

If a dev breaks this → **PR rejected**

---

## `domain/`
`domain/` defines **what the app does**, not **how it does it**.
It is the **business contract** of a feature.

```text
features/<feature_name>/domain/
├── entities/
├── repositories/
└── usecases/
```

---

## NON-NEGOTIABLE RULES
- NO Flutter imports
- NO Supabase
- NO Bloc / Cubit
- NO UI code
- NO routing
- NO storage
- NO try/catch
- NO async side-effects

`domain/` must be **pure Dart**.

---

## 1. Entities (`entities/`)
### Purpose
Represents **core business objects**.

### Rules
- Immutable
- Simple data holders
- No behavior that causes side effects
- No JSON / API parsing
- No annotations

### Allowed
- Constructors
- Value getters (derived data)

### Not Allowed
- `fromJson` / `toJson`
- Equatable dependency (optional but discouraged)
- Validation logic
- Framework types

### Example
```dart
class UserEntity {
  final String id;
  final UserRole role;

  const UserEntity({
    required this.id,
    required this.role,
  });

  bool get isOwner => role == UserRole.owner;
}
```

---

## 2. Repository Contracts (`repositories/`)
### Purpose
Defines **what data the domain needs**, not where it comes from.

### Rules
- Interfaces only
- No implementation
- No infra types
- No exceptions defined here

### Allowed
- Method signatures
- Domain entities
- Params objects

### Not Allowed
- Supabase / API models
- HTTP response types
- Database queries

### Example
```dart
abstract class AuthRepository {
  Future<UserEntity> login(
    String email,
    String password,
  );
}
```

---

## 3. Use Cases (`usecases/`)
### Purpose
Represents **one business action**.
> One use case = one intention

### Rules
- Thin
- Boring
- Delegates to repository
- No `try/catch`
- No branching logic
- No UI assumptions

### Allowed
- Parameter objects
- Repository calls
- Return domain entities

### Not Allowed
- Multiple responsibilities
- State mutation
- Context passing

### Example
```dart
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(LoginParams params) {
    return repository.login(
      params.email,
      params.password,
    );
  }
}
```

---

## 4. Params Objects (MANDATORY)
### Rules
- One params class per use case
- No primitive soup
- Immutable

### Example
```dart
class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}
```

---

## 5. Error Handling in Domain (IMPORTANT)
### Rule
**Domain does not handle errors.**
- Domain does NOT catch
- Domain does NOT throw infra exceptions
- Domain may allow `Failure` to bubble up

All error handling happens in:
- Data layer (translation)
- Bloc layer (reaction)

---

## `domain/` ENFORCEMENT CHECKLIST
Use this in every PR:

```text
domain/
[ ] Pure Dart only
[ ] No Flutter imports
[ ] No Supabase / API imports
[ ] No try/catch
[ ] No business logic branching
[ ] Entities are immutable
[ ] Use cases do one thing
```

If any rule fails → ❌ PR rejected

---

## WHY `domain/` IS STRICT
- Domain defines correctness
- Domain outlives UI
- Domain survives refactors
- Domain enables testing
- Domain enables replacement of data sources

If domain stays pure → everything else can change safely.

---

## SUMMARY

### `domain/` IS:
- Business contract
- Pure logic
- Stable
- Framework-agnostic

### `domain/` IS NOT:
- Smart
- Infrastructure-aware
- UI-aware
- Error-handling layer

---

## FINAL RULE (MOST IMPORTANT)
**If domain imports anything from Flutter or Supabase — the architecture is already broken.**
