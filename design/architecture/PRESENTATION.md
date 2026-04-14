# Architecture Rules — `presentation/`

If a dev breaks this → **PR rejected**

---

## `presentation/`
`presentation/` is the **interaction layer**.
It:
- reacts to user input
- displays state
- delegates decisions upward

It **does not know how things work** — only **what happened**.

```text
features/<feature_name>/presentation/
├── blocs/
├── pages/
└── widgets/
```

---

## NON-NEGOTIABLE RULES
- NO Supabase
- NO repositories
- NO use cases
- NO routing decisions
- NO cross-feature imports
- NO business logic

`presentation/` reacts — it never decides.

---

## 1. Bloc (`blocs/`)
### Purpose
Coordinates **user intent → domain actions → UI state**.
Bloc is the **only place** where:
- async orchestration happens
- errors are handled explicitly
- UI-friendly states are emitted

### Bloc Rules (CRITICAL)
- Blocs NEVER navigate
- Blocs NEVER use `BuildContext`
- Blocs NEVER call Supabase
- Blocs NEVER talk to another Bloc
- Blocs catch ONLY `Failure`
- Blocs emit explicit states

Violation → ❌ PR rejected

### Allowed in Bloc
- Use case calls
- `try/catch` (Failure only)
- State transitions
- Event → State mapping

### Not Allowed in Bloc
- UI widgets
- Navigation
- Snackbars / dialogs
- Repositories directly

### Example (Correct)
```dart
on<LoginRequested>((event, emit) async {
  emit(AuthLoading());

  try {
    final user = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    emit(AuthAuthenticated(user));
  } on Failure catch (e) {
    emit(AuthError(e.message));
  }
});
```

---

## 2. Events (`*_event.dart`)
### Purpose
Represent **user intent**.

### Rules
- One event = one intent
- No logic
- No async
- Immutable

### Example
```dart
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}
```

---

## 3. States (`*_state.dart`)
### Purpose
Represent **what the UI can render**.

### Rules
- Immutable
- Explicit
- Small
- UI-friendly

### Not Allowed
- Domain logic
- Side effects
- Computation

### Example
```dart
abstract class AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
```

---

## 4. Pages (`pages/`)
### Purpose
Top-level screens.
Pages connect UI to Bloc, handle side effects (snackbars, dialogs), and never contain logic.

### Page Rules
- Use `BlocListener` for side effects
- Use `BlocBuilder` for rendering
- Never call use cases
- Never contain `try/catch`
- Never navigate manually

Violation → ❌ PR rejected

### Example
```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: LoginForm(),
);
```

---

## 5. Widgets (`widgets/`)
### Purpose
Reusable UI components.

### Rules
- Stateless whenever possible
- No `BlocListener`
- No side effects
- No logic beyond UI validation

### Allowed
- Layout
- Styling
- Input fields
- UI-only validation

### Not Allowed
- Navigation
- Business rules
- Async calls

---

## 6. Navigation Rule (VERY IMPORTANT)
**`presentation/` NEVER navigates**
- No `Navigator.push`
- No `context.go`
- No `context.pop`

Navigation is handled **only** in `app/router/`.
This guarantees:
- Predictable flow
- Testability
- RBAC enforcement

---

## `presentation/` ENFORCEMENT CHECKLIST
Use this in every PR:

```text
presentation/
[ ] UI has no logic
[ ] Bloc catches Failure only
[ ] No navigation in Bloc or UI
[ ] No Supabase imports
[ ] No repository imports
[ ] Side effects handled in Pages only
```

If any rule fails → ❌ PR rejected

---

## WHY `presentation/` IS STRICT
- Keeps UI replaceable.
- Prevents logic duplication.
- Makes state predictable.
- Simplifies testing.
- Prevents navigation bugs.

If presentation stays dumb → the app stays stable.

---

## SUMMARY
### `presentation/` IS:
- UI + state coordination
- Explicit
- Reactive
- Testable

### `presentation/` IS NOT:
- Business logic
- Data access
- Navigation controller
- Decision maker

---

## FINAL RULE (MOST IMPORTANT)
**If you feel tempted to “just handle it in the UI” — Stop.** 
The logic belongs in Bloc or Domain.
