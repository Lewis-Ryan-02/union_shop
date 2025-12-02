Task: Make ProductPage (lib/product_page.dart) responsive for mobile and web/desktop while reusing existing responsive helpers (lib/responsive.dart). Do not radically redesign visual language; keep existing components (Header, Footer, helper widgets) and route behavior. Implement accessibility and automated tests.

Context:
- Repo: c:\Users\Lewis\code\git_repos\union_shop
- Key files to change: lib/product_page.dart. May also update lib/responsive.dart if needed, and tests under test/.
- Current breakpoints: mobile <600px, desktop >=600px (configurable in lib/responsive.dart).
- Tests run on Windows PowerShell: `flutter test` / `flutter test test/<file>.dart`.

User stories:
1. Phone user: On small screens (<600px) the ProductPage stacks content vertically: image, title, price, controls, description, footer. Controls are large enough to tap, inputs have minimum touch targets, and no horizontal scrolling occurs.
2. Web/desktop user: On widths >=600px show a multi-column layout: left = larger product image, center = product details and add-to-cart controls, right = additional info or related products (on sufficiently wide viewports). Inputs expand to available width but respect a minimum.
3. Keyboard user: All interactive controls are reachable by keyboard and have logical focus order. Dropdowns and text fields behave identically on web and mobile.
4. QA/CI: Automated widget tests cover representative widths 360px, 768px, 1366px and assert layout differences and no RenderFlex overflows.

Deliverables:
- Updated lib/product_page.dart:
  - Use MediaQuery/LayoutBuilder or ResponsiveLayout helper to switch layouts per breakpoint.
  - Use Flexible/Expanded and constraints so children do not overflow when page is wrapped in SingleChildScrollView.
  - Use intrinsic sizing only where safe; prefer ConstrainedBox/SizedBox and AspectRatio for images.
  - Ensure DropdownMenu/DropdownButton widths adapt to container; provide reasonable minWidth for touch.
  - Replace rigid Rows that cause overflow with Wrap, Expanded, or flexible layouts.
  - Ensure Header works (opens drawer modal) and Footer is present.
- Unit/widget tests:
  - New test file test/product_page_responsive_test.dart with 3 tests:
    - Render ProductPage at width 360 — assert menu icon present, single-column layout, no DropdownButton visible, no overflows, and key elements visible.
    - Render at width 768 — assert multi-column layout (image and details visible side-by-side) without overflow.
    - Render at width 1366 — assert desktop layout (right-side column visible or related products), inputs expand, and no RenderFlex overflow.
  - Tests must use tester.binding.setSurfaceSize and restore size in tearDown.
  - Tests must call pumpAndSettle and assert findsOneWidget/findsNWidgets and absence of overflow errors.
- Update/add any small helpers in lib/responsive.dart if needed (expose isMobile/isDesktop).

Acceptance / success criteria (testable):
- No RenderFlex overflow errors at 360, 768, 1366 in widget tests and locally in browser/emulator.
- At mobile widths: layout is single-column stacked; tap targets >=36px; no horizontal scroll.
- At desktop widths: multi-column layout with aligned controls; email/quantity inputs expand to available width but have minWidth for touch.
- Keyboard focus: tab order reaches add-to-cart, dropdowns and quantity; pressing Enter on Add to Cart triggers callback (or is focusable).
- Automated tests pass: `flutter test` returns 0 failing tests in new file(s).
- Visual sanity: product image scales maintaining aspect ratio; no clipped text or hard truncation unless intentionally set.

Constraints & notes:
- Do not remove Header or Footer; ProductPage must work on pages where parent Scaffold may not provide a drawer.
- Avoid touching unrelated features; keep naming and routes intact.
- Prefer using Responsive helper constants in lib/responsive.dart.
- Keep code idiomatic Flutter/Dart and add comments for tricky layout decisions.
- Provide a short README note (or test comment) listing how to run the new tests:
  - PowerShell: `flutter test test/product_page_responsive_test.dart`
  - For a single test: `flutter test -r expanded test/product_page_responsive_test.dart`

Example assertions to include in tests:
- expect(find.byIcon(Icons.menu), findsOneWidget) for mobile
- expect(find.byType(Row).or(find.byType(Wrap)), findsWidgets) for web/desktop layout checks
- assert no overflow by ensuring `tester.takeException()` is null after pumpAndSettle

Deliver final patch including:
- Modified lib/product_page.dart (with clear, minimal changes).
- New test(s) under test/product_page_responsive_test.dart.
- Any small updates to lib/responsive.dart (documented).
- A one-paragraph commit message describing the change and how to run tests.

If ambiguous UI details remain, propose one compact mock (mobile stacked vs web multi-column) and implement that with clear tests; prefer safe defaults over complex behavior.