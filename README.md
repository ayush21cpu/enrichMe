# ayush_enrichme_task

A new Flutter project.

## Getting Started

#  EnrichMe - Fitness Plan App (Flutter + Firebase)

A beautiful, production-ready fitness management application built in Flutter.  
The app demonstrates real-world Flutter architecture with Provider, Firebase integration, Firestore CRUD operations, and a polished UI experience.

---

##  Features

###  User Authentication (Firebase Auth)
- Email/Password based login & registration
- Firebase Authentication integration
- Auto login handling using `FirebaseAuth.instance.currentUser`
- User data stored in Firestore under `users` collection

###  Splash Screen with Animation
- Clean animated splash screen added using Flutter `AnimatedOpacity` & `Future.delayed`
- Automatically checks if user is logged in:
    - If ✅: Redirects to Fitness Plan List
    - If ❌: Redirects to Login Page

###  Firebase Firestore Integration
- Fitness plans saved in `fitness_plans` collection
- Users stored in `users` collection with UID & email
- Assigned plans saved in `assigned_plans` collection using `userId` and `planId`
- Firestore is used to join user-plan relationships

###  Plan Assignment Flow (Coach Panel)
- Coach can assign a fitness plan to any registered user
- User dropdown dynamically loaded from Firestore
- UID-safe assignment (uses FirebaseAuth UID, not doc ID)

###  Assigned Plans (User Panel)
- User can view their assigned fitness plans
- Firestore query with join logic
- Shows plan title, description, type

###  State Management
- Provider used to manage authentication, user state, fitness plan state
- `ChangeNotifier`-based reactive updates
- `FitnessPlanProvider`, `UserProvider` implemented

###  UI & UX
- Material 3 theming
- Clean, card-based layouts
- Icons, spacing, consistent elevation
- `Shimmer` loader used during async states
- Snackbar-based success & error messages
- Full null safety, responsive UI

---

##  Folder Structure

lib/
├── main.dart
├── screens/
│ ├── splash_screen.dart
│ ├── login_page.dart
│ ├── register_page.dart
│ ├── fitness_plan_list_page.dart
│ ├── assign_plan_page.dart
│ └── assigned_plans_page.dart
├── models/
│ ├── fitness_plan.dart
│ └── user_model.dart
├── services/
│ ├── auth_service.dart
│ └── database_service.dart
└── viewModel/
---
##  Firebase Setup (For Testing / Review)

- Auth method enabled: **Email/Password**
- Firestore collections:
    - `users`: Stores `uid` + `email`
    - `fitness_plans`: Stores plan `title`, `description`, `type`
    - `assigned_plans`: Stores `userId` (Firebase UID) + `planId`
- Firebase initialized via `firebase_core`
- Firestore accessed via `cloud_firestore`

---
##  Packages Used
```yaml
firebase_core
firebase_auth
cloud_firestore
provider
shimmer