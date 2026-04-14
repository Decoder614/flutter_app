# Architecture Rules — `shared/`

If a dev breaks this → **PR rejected**

### `shared/`
`shared/` is our **internal UI Kit and Design System**.
It contains **highly reusable, visually consistent** Flutter widgets.
It is completely **feature-agnostic** and strictly **dumb**.

```text
shared/
├── buttons/      <- PrimaryButton, OutlineButton, IconButton
├── dialogs/       <- CustomBottomSheet, WarningDialog, SuccessSnackbar
├── images/        <- Image wrappers, SVG handlers
├── inputs/        <- Text fields, dropdowns, toggles
├── layouts/       <- Scaffolds, responsive wrappers
├── loaders/       <- Spinners, shimmer layouts
├── screens/       <- Generic error/empty state screens
├── theme/         <- AppColors, Typography, ThemeData
└── widgets/       <- Spacers, dividers, generic items
```

---

## NON-NEGOTIABLE RULES
- NO feature imports (e.g., `import 'package:app/features/...';` → ❌)
- NO knowledge of Domain Entities (e.g., `final User user;` → ❌)
- NO Data layer imports (No Repositories, No Supabase)
- NO Bloc / State Management logic
- NO hardcoded Colors or Spacings

`shared/` **must only draw pixels and emit callbacks**.

---

## 1. The "Dumb Widget" Rule
### Purpose
Ensure all UI components are completely independent and reusable.

### Rules
- Widgets in `shared/` **must not fetch their own data**.
- Data is passed down via constructor arguments.
- User actions are passed up via callback functions (`VoidCallback`, `ValueChanged<T>`, etc.).

### Enforcement
- **Allowed:** `final String title; final VoidCallback onTap;`
- **Not Allowed:** `final UserEntity user; context.read<UserBloc>().add(LoadUser());`

---

## 2. No Hardcoded Styling
### Purpose
Maintain a **Single Source of Truth** for the app's visual identity.

### Rules
- NEVER use raw Colors (e.g., `Colors.red`).
- NEVER use raw numbers for standard spacing (e.g., `SizedBox(height: 15)`).
- ALWAYS use the `shared/theme/` definitions (e.g., `AppColors.primary`, `AppSpacings.paddingMedium`).

### Enforcement
> If a PR contains a raw color or a magic number for padding inside `shared/`, it gets rejected.

---

## 3. `shared/screens/` Exception
### Purpose
Houses completely generic screens that do not belong to a specific business feature.

### Allowed
- `ErrorScreen` (Accepts an error message string and a retry callback)
- `EmptyStateScreen` (Accepts an icon and a message)
- `WebViewScreen` (Accepts a URL string)

### Not Allowed
- `LoginScreen` (Belongs in `features/auth/`)
- `ProfileScreen` (Belongs in `features/profile/`)

---

## 4. `shared/theme/`
### Purpose
The absolute bedrock of the App's UI.

### Responsibilities
- `AppColors`: All hex codes and palette definitions.
- `AppTypography`: Font sizes, weights, and text styles.
- `AppThemeData`: The global `ThemeData` object provided to `MaterialApp`.

---

## SHARED ENFORCEMENT RULES (CRITICAL)
Put this in **code review checklist**:

```text
shared/
[ ] Does not import any file from features/
[ ] Does not import any Bloc or state management
[ ] Does not reference any Domain Entity or Data Model
[ ] Does not contain hardcoded colors or text styles
[ ] Uses exactly generic callbacks (onTap, onChanged)
```

If any rule is broken → ❌ PR rejected

---

## WHY `shared/` IS STRICT
- `shared/` ensures the app **looks identical** on every screen.
- `shared/` prevents duplicate code (e.g., writing `PrimaryButton` 10 times).
- `shared/` makes UI testing trivial, as it requires zero mocking of network or databases.

If `shared/` stays clean → building new features becomes as easy as snapping together Lego bricks.
