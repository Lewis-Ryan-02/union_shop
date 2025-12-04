**Project**

- **Name:** `union_shop`
- **Description:** A Flutter application for the University of Portsmouth union shop — a small e-commerce-style app showcasing products, collections, a print shack, and a cart backed by a `CartService` using `shared_preferences`.

**Contents**

- **Languages & Frameworks:** Dart, Flutter
- **Project type:** Flutter multi-platform app (mobile, web, desktop)
- **Entry point:** `lib/main.dart`
- **Pubspec:** `pubspec.yaml`

**Quickstart — Prerequisites**

- **Flutter SDK:** Install Flutter (stable channel recommended). Follow official instructions: https://flutter.dev/docs/get-started/install
- **Platform tools:** For Android: Android SDK/Android Studio; For iOS/macOS: Xcode; For Windows: Visual C++ build tools (if building desktop). Ensure `flutter doctor` is clean.

**Install dependencies**

Run from the project root:

`flutter pub get`

**Run (development)**

- Run on connected device or an emulator:

`flutter run`

- Run on a specific device (example: web or windows):

`flutter run -d <device-id>`

Examples:

`flutter run -d chrome`

`flutter run -d windows`

**Build (release)**

- Android APK:

`flutter build apk --release`

- Android App Bundle:

`flutter build appbundle --release`

- iOS:

`flutter build ios --release` (requires macOS + Xcode)

- Web:

`flutter build web --release` (output in `build/web`)

- Windows/macOS/Linux desktop:

`flutter build windows` / `flutter build macos` / `flutter build linux`

**Tests**

- Run unit/widget tests located in the `test/` folder:

`flutter test`

The repository contains numerous tests such as `cart_service_test.dart`, `product_test.dart` and UI responsiveness tests. Running `flutter test` will execute all available tests.

**Project structure (high level)**

- `lib/` — application source
	- `main.dart` — app entry; sets up `CartService` & routes
	- `products.dart` — product definitions and product page widgets
	- `cart/` — cart service and related UI (e.g., `cart_service.dart`, `ui/cart/cart_page.dart`)
	- `views/` — screens: home, collections, about, print shack, sign-in, etc.
	- `ui/`, `widgets/` — shared UI components and smaller widgets
- `assets/` — static assets (images under `assets/images/`)
- `test/` — unit & widget tests
	- `test/pages/` — page tests
- `android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/` — platform folders and configurations
- `pubspec.yaml` — Dart/Flutter metadata & dependencies
- `analysis_options.yaml` — lint rules

**Dependencies (key)**

- `provider` — state management used for `CartService`
- `shared_preferences` — persistence used by `CartService`
- `flutter_lints`, `flutter_test` — linting and tests

**Notable behaviour & routes**

- The app's routes are defined in `lib/main.dart`. Important routes include `/`, `/about`, `/signin`, `/collections`, `/print-shack`, and `/cart`. Product pages are registered with named routes coming from `products.dart`.
- `CartService` is created before `runApp` and provided to the widget tree using `Provider`.

**Contributing**

- All the work is done by me (except the good bits, that was AI)