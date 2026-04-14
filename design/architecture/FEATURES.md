# Architecture Rules — `features/`

If a dev breaks this → **PR rejected**

---

## `features/`
`features/` is where **all product behavior lives**.
Every feature is:
- Isolated
- Independently testable
- Owned by a team/member
- Vertically sliced (data → domain → presentation)

```text
features/
├── auth/
├── dashboard/
├── profile/
└── <feature_name>/
```

---

## NON-NEGOTIABLE RULES
- NO cross-feature imports
- NO shared logic between features
- NO feature talking directly to another feature
- NO global state inside features
- NO navigation decisions inside features

Features **do not know about each other**.
If two features need shared logic → it belongs in `core/` or `shared/`.

---

## FEATURE OWNERSHIP RULE (MANDATORY)
- Each feature has **one owner**
- Only owner approves cross-feature changes
- One feature per PR (max)

This is how large teams stay sane.

---

## STANDARD FEATURE STRUCTURE
Every feature **MUST** follow this structure:

```text
features/<feature_name>/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── blocs/
│   ├── pages/
│   └── widgets/
└── <feature_name>_exports.dart
```
Deviation → ❌ PR rejected

---

## 1. Feature Isolation
### Rules
A feature **may** import:
- `core/`
- `shared/`
- its own subfolders

A feature **may NOT** import:
- another feature
- `app/`
- routing logic

---

## 2. `domain/` (Business Contract)
### Purpose
Defines **what the feature does**, not **how**.

👉 **[See DOMAIN.md for strict rules enforcing pure business logic and 100% Flutter independence.](DOMAIN.md)**

### Rules
- Pure Dart only
- No Flutter
- No Supabase
- No Bloc
- No try/catch
- No side effects

### Contains
- Entities
- Repository interfaces
- Use cases

Domain must be **stable and boring**.

---

## 3. `data/` (Implementation)
### Purpose
Implements **how the feature works**.

👉 **[See DATA.md for strictly enforced rules regarding datasources, models, and repositories.](DATA.md)**

### Rules
- Talks to Supabase / APIs
- Handles infra exceptions
- Translates errors to Failure
- Implements domain repositories

### Allowed
- Supabase
- Dio / HTTP
- Local storage
- `try/catch`

### Not Allowed
- UI imports
- Bloc imports
- Business decisions

---

## 4. `presentation/` (UI + State)
### Purpose
Handles **user interaction and state**.

👉 **[See PRESENTATION.md for strictly enforced rules forbidding UI logic and navigation.](PRESENTATION.md)**

### Rules
- UI is dumb
- Bloc is explicit
- No repository access
- No Supabase
- No navigation calls

### Responsibilities
- Emit events
- React to states
- Show feedback

Bloc decides **what happened**, not **what to do next**.

---

## 5. Bloc Rules (CRITICAL)
**Bloc rules:**
- No navigation
- No `BuildContext` in logic
- Catch only `Failure`
- No `try/catch` in UI
- One responsibility per Bloc

Violation → ❌ PR rejected

---

## 6. Feature Exports (`*_exports.dart`)
### Purpose
Controls what a feature exposes.

### Rules
- Router imports ONLY this file
- No deep imports allowed
- Public API is explicit

---

## 7. Dependency Injection
### Rules
- Features DO NOT self-register
- Registration happens ONLY in `app/di/injection.dart`
- Feature has no knowledge of DI container

---

## 8. Feature Communication (IMPORTANT)
Features **never communicate directly**.
If communication is required:
- Use shared state in `core/` or `app/blocs/`
- Use backend as mediator
- Use events at app level (rare)

**Never:**
- Call another feature’s Bloc
- Import another feature’s files

---

## `features/` ENFORCEMENT CHECKLIST
Use this in every PR:

```text
features/
[ ] No cross-feature imports
[ ] Domain is pure Dart
[ ] Data handles infra & errors
[ ] Bloc catches Failure only
[ ] UI has zero logic
[ ] Feature registered in DI
[ ] Feature exposed via exports file
```
If any rule fails → ❌ PR rejected

---

## WHY `features/` IS STRICT
- Enables parallel development
- Prevents coupling
- Makes features removable
- Improves testability
- Makes ownership clear

If features stay isolated → the app scales.

---

## SUMMARY
### `features/` IS:
- Vertical slices
- Business logic boundary
- Independently testable
- Team-owned

### `features/` IS NOT:
- Shared code dumping ground
- Navigation layer
- DI container
- Global state holder

---

## FINAL RULE (MOST IMPORTANT)
**If code inside a feature feels “generic” — It probably belongs in `core/` or `shared/`.**
Move it.
