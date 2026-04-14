# Architecture Rules — `core/`

If a dev breaks this → **PR rejected**

### `core/`
`core/` is the **foundation layer**. It contains **cross-cutting abstractions** used by all features.
It is **feature-agnostic**, **framework-agnostic**, and **boringly stable**.

```text
core/
├── constants/
│   └── app_constants.dart
├── errors/
│   ├── exceptions.dart
│   └── failures.dart
├── extensions/
│   └── context_extensions.dart
├── network/
│   └── network_info.dart
├── services/          <- Wrappers for external SDKs
├── storage/           <- Local DB abstractions
├── usecase/
│   └── usecase.dart
└── utils/
    └── typedefs.dart
```

---

## NON-NEGOTIABLE RULES
- NO feature imports
- NO Supabase
- NO Bloc / Cubit
- NO UI widgets
- NO routing
- NO business logic
- NO app-specific assumptions

`core/` **must not know what the app does**.

---

## 1. `core/errors/`
### Purpose
Defines **how errors are modeled and propagated** across the app.
This is the **only place** where error abstractions live.

### Rules
- Infra exceptions are translated **before leaving the data layer**
- Bloc handles errors **explicitly**
- UI never catches errors

### Files
#### `exceptions.dart`
Used **only inside data layer**. Represents low-level technical problems (API, cache, auth, etc.)
- **Allowed:** `ServerException`, `CacheException`, `UnauthorizedException`
- **Not allowed:** Throwing `Exception`, Throwing `String`

#### `failures.dart`
**Typed, UI-safe, catchable**. Can be thrown and caught. Can be shown to users.
- **Rules:** Failures may implement `Exception`. Only Failures are allowed to cross into Bloc.

---

## 2. `core/usecase/`
### Purpose
Defines the **application action contract**.
A use case represents **one intention**:
- "User wants to log in"
- "User wants to fetch profile"

### Rules
- One use case = one action
- No UI logic
- No try/catch here
- No dependencies except repositories

- **Allowed:** `UseCase<Output, Params>`, `NoParams`
- **Not allowed:** Passing `BuildContext`, Multiple responsibilities

---

## 3. `core/network/`
### Purpose
Abstracts **connectivity awareness**.
This allows:
- Offline handling
- Predictable failures
- Testability

### Rules
- Only abstractions live here. Implementations belong in the data layer.
- Never directly check connectivity in Bloc or UI.

---

## 4. `core/utils/`
### Purpose
Shared **type helpers and aliases**.

### Rules
- Must be generic
- Must be reusable across features
- No feature-specific helpers

**Examples:** `typedefs`, shared helpers.

---

## 5. `core/constants/`
### Purpose
Central place for **non-environment constants**.

### Rules
- No magic numbers
- No feature-specific values
- No API keys
- No environment values

**Allowed:** timeouts, retry counts, app-wide limits.

---

## 6. `core/extensions/`
### Purpose
Small, **safe convenience extensions**.

### Rules
- Stateless
- Predictable
- No side effects
- No business logic

**Allowed:** `BuildContext` helpers, formatting helpers.
**Not allowed:** Navigation, Auth checks, Feature logic.

---

## CORE ENFORCEMENT RULES (CRITICAL)
Put this in **code review checklist**:

```text
core/
[ ] Does not import features
[ ] Does not import app/
[ ] Does not import Supabase
[ ] Does not import Bloc
[ ] Does not contain business logic
[ ] Does not assume user state
```

If any rule is broken → ❌ PR rejected

---

## WHY `core/` IS STRICT
- `core/` should change **the least**
- `core/` should be **safe to depend on**
- `core/` should survive app rewrites
- `core/` enables feature isolation
- `core/` prevents architecture erosion

If `core/` stays clean → the app scales.

---

## SUMMARY
### `core/` is:
- Stable
- Boring
- Reusable
- Framework-agnostic
- Team-safe

### `core/` is NOT:
- Smart
- Feature-aware
- UI-aware
- App-aware
