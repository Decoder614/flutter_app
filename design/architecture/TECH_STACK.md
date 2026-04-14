# 🛠️ Technology Stack & Onboarding

Welcome to the `location_app` project. This document outlines the exact tools, third-party packages, and configuration steps required to develop this application. 

**All team members must use these standardized tools to ensure environment consistency.**

---

## 1. Core Framework
- **Flutter:** (Targetting stable channel, consult `pubspec.yaml` for exact version bounds).
- **Dart:** SDK `>=3.0.0`
- **Architecture:** Feature-First Clean Architecture ([See ARCHITECTURE.md](ARCHITECTURE.md))

---

## 2. Approved Third-Party Packages
To prevent dependency bloat, you **may not add new packages to `pubspec.yaml` without team lead approval.** Here are our approved core packages:

### State Management & Architecture
- **[`flutter_bloc`](https://pub.dev/packages/flutter_bloc):** Our exclusive state management solution. Used strictly for orchestrating user intent to domain logic.
- **[`get_it`](https://pub.dev/packages/get_it):** Our Service Locator for Dependency Injection. See `app/di/injection.dart`.

### Routing
- **[`go_router`](https://pub.dev/packages/go_router):** Used for all declarative routing, deep linking, and Route-Based Access Control (Auth gating).

### Backend & Network
- **[`supabase_flutter`](https://pub.dev/packages/supabase_flutter):** Our primary backend-as-a-service for Authentication and Database.
- **[`dio`](https://pub.dev/packages/dio):** (If used) For raw REST API calls and interacting with third-party web services.

### Storage & Utility
- **[`shared_preferences`](https://pub.dev/packages/shared_preferences) / [`hive`](https://pub.dev/packages/hive):** For synchronous/asynchronous local key-value caching.
- **[`equatable`](https://pub.dev/packages/equatable):** For value-based equality in Domain Entities and Bloc States.

---

## 3. Local Setup & Configuration Steps

### Step 1: Initial Setup
1. Clone the repository.
2. Run `flutter clean` & `flutter pub get`.
3. *(If using code generation like Freezed or custom builders in the future)* run:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Step 2: Environment Variables
**Do not hardcode API keys!** We use external environment configurations.
1. Copy the `.env.example` file to `.env` in the root of your project.
2. Request the current Dev/Staging Supabase keys from the team lead.
3. Add them to your local `.env`:
   ```text
   SUPABASE_URL=your_dev_url_here
   SUPABASE_ANON_KEY=your_dev_key_here
   ```

### Step 3: IDE Configuration (VS Code / Android Studio)
- **Format on Save:** Ensure `dart format` is triggered automatically on save.
- **Linter Enforcements:** We strictly adhere to `analysis_options.yaml`. Do not ignore, suppress, or disable lint warnings in your PRs.
- **Line Length:** Keep lines under 80-100 characters for readability.

---

## 4. Running the Project

### Flavors / Environments
If the project uses flavors, never just run `flutter run`. Specify the environment explicitly to ensure you do not accidentally write testing data to production databases:
- **Development:** `flutter run --flavor dev -t lib/main_dev.dart`
- **Production:** `flutter run --flavor prod -t lib/main.dart`

*(Adjust the exact commands based on our active flavor setup).*

---

## 5. Adding New Dependencies
Why are we so incredibly strict about adding new packages?
1. **Security Risk:** Abandoned packages introduce vulnerabilities.
2. **Maintenance Debt:** Packages break with new Flutter versions, preventing the whole app from upgrading.
3. **App Size:** Unnecessary dependencies bloat the final APK/IPA.

**Before requesting to add a package, ask yourself:**
- *Can I write this myself in a few hours using native Dart/Flutter?* (If yes, do not add the package. Write it in `core/utils/` or `shared/widgets/`).
- *Is this package created by a trusted publisher (e.g., flutter.dev, Very Good Ventures, Firebase)?*
- *Has it been updated in the last 6 months?*

If it passes all checks, present the justification in your PR description for architectural review.
