# Architecture Rules — `app/`

If a dev breaks this → **PR rejected**

---

## `app/`
`app/` is the **composition root** of the application.
- It **does not contain business logic**.
- It **does not implement features**.
- It **does not make decisions**.

Its only job is to **wire the system together**.

```text
app/
├── app.dart
├── blocs/
│   ├── auth_bloc.dart
│   └── theme_bloc.dart
├── bootstrap.dart
├── di/
│   └── injection.dart
└── router/
    ├── app_router.dart
    └── router_refresh_notifier.dart
```

---

## NON-NEGOTIABLE RULES
- NO business logic
- NO feature-to-feature coordination
- NO Supabase calls
- NO repositories, models, or entities
- NO feature-specific Bloc logic (only App-wide providers like Auth/Theme)
- NO navigation decisions inside features

`app/` **orchestrates**, nothing else.

---

## 1. `bootstrap.dart`
### Purpose
Single entry point for **application startup**.

### Responsibilities
- Initialize Flutter bindings
- Initialize Supabase
- Initialize dependency injection
- Start the app

### Rules
- NO conditional logic
- NO feature imports
- NO async work beyond setup
- NO environment decisions beyond configuration

### Why this exists
Predictable startup. Easy testing & flavor switching. Zero logic in `main.dart`. Safe place for platform initialization.

---

## 2. Dependency Injection — `get_it`
📍 `app/di/injection.dart`

### Purpose
The **only place** where dependencies are wired.

### Responsibilities
- Register core services
- Register feature datasources
- Register repositories
- Register use cases
- Register blocs

### Rules
- Features NEVER register themselves
- Every dependency must be registered here
- No hidden registrations
- No conditional registrations per feature

### Enforcement
> If a dependency is not registered here, it does not exist.
> 
> Violation → ❌ PR rejected

---

## 3. Router — `go_router`
📍 `app/router/`

### Purpose
Centralized navigation + access control.

### Allowed
- Auth guards
- Role-based redirects
- Route definitions

### Not Allowed
- Supabase access
- Feature logic
- Business rules
- Async calls inside redirect

### Rules
- Blocs NEVER navigate
- UI NEVER decides routes
- Router reacts to **AuthBloc state**
- Router enforces auth + RBAC

---

## 4. `app_router.dart`
### Responsibilities
- Define routes
- Enforce authentication
- Enforce role-based access control
- Handle unauthorized redirects

### Rules
- Router reads Bloc state only
- Router never mutates state
- Router never calls use cases

---

## 5. Root App Widget — `app.dart`
### Purpose
Application shell.

### Responsibilities
- Attach router
- Provide global blocs
- Configure theme
- Configure localization

### Rules
- No feature logic
- No auth logic
- No business rules
- No conditional rendering based on state

This file should be **boring and stable**.

---

## 6. Global State — `app/blocs/`
### Purpose
Store application-wide state that multiple features depend on (e.g., Authentication status, Theme mode, Localization).

### Rules
- ONLY globally scoped state goes here
- NO feature-specific logic (e.g., `ShoppingCartBloc` ❌)

---

## `app/` ENFORCEMENT CHECKLIST
Use this in every PR:

```text
app/
[ ] No business logic
[ ] No Supabase usage
[ ] No models/entities
[ ] No repositories
[ ] No use cases
[ ] No feature imports except UI entry points
[ ] No navigation in Bloc
```
If any box fails → ❌ PR rejected

---

## WHY `app/` IS STRICT
- `app/` defines **system boundaries**
- `app/` prevents feature coupling
- `app/` keeps startup predictable
- `app/` keeps navigation centralized
- `app/` is the only place allowed to “see everything”

If `app/` stays clean → the architecture survives scale.

---

## SUMMARY

### `app/` IS:
- Orchestration layer
- Composition root
- Wiring & configuration
- Navigation authority

### `app/` IS NOT:
- Smart
- Feature-aware
- Business-aware
- Data-aware

---

## FINAL RULE (MOST IMPORTANT)
**If you’re unsure whether code belongs in `app/` — It probably doesn’t.**
Move it out.
