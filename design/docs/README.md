# Product Documentation (SRS, User Stories, Epics)

This folder contains **feature-level product documentation** for the `location_app` project. These documents focus on **what** the features should do and **how** they should behave from a user perspective, rather than technical implementation details.

---

## 🏗 Features Index

| Feature Epic | Description | Document Link |
|---|---|---|
| `about_us` | Static informational page about mission and team | [about_us.md](about_us/about_us.md) |
| `example_feature` | Reference Epic for API data loading and state management | [example_feature.md](example_feature/example_feature.md) |
| `location` | Automated Check-in/out via Geofencing | [location/location_selection.md](location/location_selection.md) |

---

## 📝 Documenting a New Feature

When creating a new feature (e.g. `location_selection`), follow this documentation structure:

1. **Overview:** High-level description of why this feature exists.
2. **User Stories:** (AS A, I WANT, SO THAT) format + **Acceptance Criteria**.
3. **Product Requirements (SRS):** Detailed functional and non-functional requirements.
4. **Epic Backlog:** List of future enhancements for the feature.

---

## 🔗 Related Documentation

| Type | Directory | Purpose |
|---|---|---|
| **Technical Design** | `design/architecture/` | Implementation rules, layer details, and core logic. |
| **Source Code** | `lib/features/` | Actual Dart code implementation. |
| **System Design** | `design/src/` | Visual design tokens and shared UI components. |

> 📌 **Note:** For technical implementation details (Bloc names, Repository interfaces, etc.), refer to the `design/architecture/` documentation.
