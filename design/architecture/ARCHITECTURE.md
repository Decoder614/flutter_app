# 🏛️ Flutter Feature-First Clean Architecture Guidelines

Welcome to the `location_app`! This document outlines our strict architectural standards. This is **how we build software**. These are **not suggestions**. 
**If a decision violates these principles → the decision is wrong, even if it “works”.**
**If a dev breaks these → PR rejected.**

👉 **[See TECH_STACK.md for the mandatory list of approved packages and setup instructions.](TECH_STACK.md)**

---

## 🛑 Core Principles (Non-Negotiable)

### 1. Feature-First Architecture
We organize code by **features**, not by technical layers.
- **Why:** Features scale, layers don't. Enables parallel development, clear ownership, and easier onboarding.
- **Rule:** Code is grouped by WHAT it does, not HOW it does it. If you need shared logic → it belongs in `core/` or `shared/`, not a "shared feature".

### 2. Unidirectional Data Flow
All data flows in **one direction only**: `UI → Bloc → UseCase → Repository → Datasource`
- **Why:** Predictable state, easier debugging, testable flows, no hidden side effects.
- **Rules:** UI emits events. Bloc coordinates. Domain executes intent. Data fetches from infra. Reverse flow → ❌

### 3. UI Knows Nothing About Data Sources
UI must never know where data comes from, how data is fetched, or how data is stored.
- **Rules:** No Supabase/Firebase in UI. No repositories in UI. No models in UI. UI only reacts to **Bloc state**. If UI knows how data is fetched → architecture is broken.

### 4. Bloc Only Coordinates (No Business Logic)
Bloc is an **orchestrator**, not a decision maker. Bloc decides WHAT happened, not WHAT it means.
- **Bloc is allowed to:** React to events, call use cases, handle errors, emit states.
- **Bloc is NOT allowed to:** Contain business rules, validate domain logic, calculate outcomes, navigate.

### 5. Domain Layer Is Flutter-Agnostic
The domain layer must be **pure Dart**.
- **Why:** Business rules outlive frameworks. Easier testing. Replaceable UI & data layers.
- **Rules:** No Flutter imports. No Supabase. No Bloc. No try/catch. No side effects. If Flutter disappears tomorrow, **domain must still compile**.

### 6. External Services Exist Only in Data Layer
External services (like Supabase, Firebase, HTTP clients) are **implementation details**, not app concepts.
- **Rules:** DB/Network imports allowed ONLY in `data/` or `core/network/`. External types never leave the data layer. Domain & Bloc must not know they exist. If Supabase leaks upward, the architecture has failed.

### 7. Everything Is Injectable
No hidden dependencies. No globals. No magic singletons.
- **Rules:** All dependencies go through constructors. All dependencies are registered in `app/di/`. `get_it` is the single source of truth.
- **Why:** Testability, replaceability, clear system graph. If you can’t mock it → it’s wrong.

### 8. Testability > Convenience
We optimize for clarity, predictability, and testability. Not for shortcuts, fewer files, or faster hacks.
- **Rules:** Explicit over clever. Boring over smart. Slight duplication > hidden coupling. If it’s hard to test, it’s poorly designed.

### 9. Explicit > Implicit (Cultural Rule)
This is a **team rule**, not just architecture.
- **We prefer:** Explicit states, explicit errors, explicit flows.
- **We avoid:** Magic, "this usually works", hidden behavior.
- **Rule:** Code should be readable by a new dev at 3am under pressure.

### 10. Architecture > Features
Features can wait. Architecture debt compounds.
- **Rule:** We never sacrifice architecture to ship faster. Shortcuts today = rewrites tomorrow.

---

## 📂 Directory Structure Rules

Our `lib/` directory is partitioned into 4 strict domains to enforce the above principles. Here is the blueprint of the architecture:

```text
lib/
├── app/
│   ├── app.dart
│   ├── blocs/         <- Global Blocs/Providers (Auth, Theme, etc.)
│   ├── bootstrap.dart
│   ├── di/
│   └── router/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/    <- Dart extensions (e.g., String validation)
│   ├── network/       <- HTTP/GraphQL clients, interceptors
│   ├── services/      <- Third-party wrappers (Firebase, Analytics)
│   ├── storage/
│   └── utils/         <- Pure Dart helper functions (Date formatters)
├── features/
│   ├── about_us/      <- "Pure UI" feature example (No Data/Domain needed!)
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   └── example_feature/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── blocs/
│           ├── pages/
│           └── widgets/
└── shared/
    ├── buttons/      
    ├── dialogs/       <- Bottom sheets, snackbars, modals
    ├── images/        <- Image wrappers, SVG handlers
    ├── inputs/        <- Text fields, dropdowns, toggles
    ├── layouts/       <- Scaffolds, responsive wrappers
    ├── loaders/       <- Spinners, shimmer layouts
    ├── screens/       <- Generic error/empty state screens
    ├── theme/         <- AppColors, Typography, ThemeData
    └── widgets/       <- Spacers, dividers, generic items
```

### 1. `app/` (Application Core)
Responsible for app initialization and global wiring.

👉 **[See APP.md for strict rules and enforcement checklist](APP.md)**

- **Allowed:** `bootstrap.dart`, `app.dart`, Dependency Injection (`di/`), Routing (`router/`), and Global State (`blocs/` for App/Auth/Theme).
- **Rule:** Never put feature-specific screens or logic here.

### 2. `core/` (Infrastructure & Cross-Cutting Concerns)
Responsible for generic infrastructure that is **NOT UI**.

👉 **[See CORE.md for strict rules and enforcement checklist](CORE.md)**

- **Allowed:** `network/` (Dio/GraphQL), `services/` (Firebase/Crashlytics), `storage/` (Hive/SharedPreferences), `utils/`, `extensions/`, `errors/` (Failure models), `constants/`.
- **Rule:** 🚫 **NO FLUTTER UI CODE (Widgets) ALLOWED IN CORE.** If it imports `material.dart` directly to draw something, it probably belongs in `shared/` or `features/`.

### 3. `shared/` (Design System / UI Kit)
Our internal UI library. Reusable components that *any* feature can confidently import.

👉 **[See SHARED.md for strict rules and enforcement checklist](SHARED.md)**

- **Allowed:** `theme/` (AppColors, Typography), `buttons/`, `inputs/`, `dialogs/`, `loaders/`, `images/`, `layouts/`, and completely dumb `screens/` (like an ErrorScreen).
- **Rule:** 🚫 **NO FEATURE-SPECIFIC CODE.** A Widget in `shared/` should never know what a "UserProfile" or "LocationData" is. It should accept primitive data (Strings, void callbacks, Enums).

### 4. `features/` (Isolated Business Capabilities)
The bulk of your work happens here. Each feature is essentially its own mini-app.

👉 **[See FEATURES.md for strict rules and enforcement checklist](FEATURES.md)**

**Clean Architecture inside Features:**
- **`data/`**: Repositories implementations, Data Sources (Remote/Local), Models (DTOs).
- **`domain/`**: Entities, Use Cases, Repository Interfaces. *(Must be pure Dart!)*
- **`presentation/`**: Pages, Widgets, State Management (Blocs/Providers).

**⚠️ The "Boilerplate Fatigue" Exception:**
If your feature is *purely UI* (e.g., an `about_us` static page) and does not interact with the network or database, **skip `data/` and `domain/`**. Only create a `presentation/` folder. Do not create empty Repositories and UseCases just to check boxes.

---

## 🚓 Pull Request Rejection Guidelines

Reviewers MUST reject PRs if any of the following occur:

1. **Cross-Feature Imports (The Cardinal Sin):** A feature cannot directly import files from another feature. *(e.g., `features/home` cannot import `features/profile/data/models/user.dart`).* Use global state or pass data via routing.
2. **Framework Leakage in Domain:** Imports of `dart:ui`, `package:flutter`, or external SDKs in the `domain/` layer.
3. **Hardcoded UI Values:** Using `Colors.red` or `SizedBox(height: 15)` instead of accessing `shared/theme/`. All styling must use the design system.
4. **Indiscriminate Dumping into `shared/widgets/`:** Custom Buttons or Inputs must go to their specific folders (`shared/buttons/`, `shared/inputs/`). Don't dump generic widgets indiscriminately.
5. **Bloated `main.dart`:** Initializing services directly in `main.dart` instead of routing through `bootstrap.dart` and DI.

---

### Final Rule (Most Important)
**If a piece of code feels "out of place", it probably is.**
Stop. Ask. Fix it properly.

> **This is not over-engineering. This is how production apps survive teams, scale, and time.**
