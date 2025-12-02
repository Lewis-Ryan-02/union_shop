# Responsive UI Requirements — Footer & Helpers

Version: 1.0  
Target: Flutter (web + Android + iOS)  
Purpose: Make the app UI adapt across phone and desktop. Primary focus: responsive Footer and small reusable helper utilities.

## Summary
Replace the current fixed-width Row-based footer with a responsive implementation that adapts to screen width and orientation. Provide configurable breakpoints, helper utilities, accessibility considerations, and automated tests validating layout at representative widths.

## Goals
- Provide a usable, readable footer across devices.
- Avoid overflow and layout breakage on small viewports.
- Reuse responsive helpers across the app.
- Deliver automated tests for three breakpoints.

## Breakpoints (default)
- Mobile: width < 600 px
- Desktop: width >= 600 px

These breakpoints must be configurable via constants in a single helper file.

## Feature description
- Footer switches between:
  - Mobile: stacked single-column layout, readable fonts, larger vertical spacing.
  - Desktop: three-column row layout (left, middle, right) without fixed pixel widths.
- Email subscription TextField expands to available width but respects a minimum touch target.
- Text wraps correctly; no hard truncation unless explicitly designed.
- Keyboard, focus, and clear behavior works correctly on web and mobile.

## User stories
1. Phone user: wants stacked footer content, readable fonts, tappable controls, no horizontal scroll.
3. Desktop/web user: wants multi-column footer with aligned elements and a keyboard-friendly email input.
4. QA: wants automated tests and visual checks for breakpoints 360px, 768px, 1366px.

## Acceptance criteria (testable)
- Responsive Footer widget created and used instead of the current footer.
- Breakpoints exposed and configurable in lib/responsive.dart.
- Layout behavior:
  - Mobile: content in a single vertical column, each section full width.
  - Desktop: 3-column horizontal layout.
- No overflow or pixel overflow runtime errors at breakpoints.
- Long text wraps; no unexpected truncation.
- Email field:
  - Accepts keyboard input on web.
  - Has semantic label and accessible hint.
  - Subscribe button clears the field.
- Tests:
  - At least one widget test for each breakpoint asserting arrangement type (Column vs Row or expected widget tree).
  - Golden or screenshot tests for mobile, desktop widths (recommended).
- Documentation:
  - Code comments or a README explaining breakpoints and where to change them.
- Backwards compatibility: imports unchanged for footer usage.

## Deliverables / Subtasks
1. Design & spec (code comments)
   - Add inline comments in code explaining breakpoints and responsive strategy.

2. Implement helper utilities
   - File: lib/responsive.dart
   - Export:
     - breakpoint constants (MOBILE_MAX, DESKTOP_MIN)
     - helpers: bool isMobile(BuildContext), isDesktop(BuildContext)
     - optional: ResponsiveLayout widget or a selectForWidth<T>(maxWidth, mobile, desktop) helper.

3. Implement responsive Footer widget
   - File: lib/footer.dart (modify existing)
   - Use LayoutBuilder and responsive helpers.
   - Replace fixed SizedBox widths with Flexible/Expanded or constraints-based sizing.
   - Ensure TextField minWidth for touch targets; set semantic label and keyboard type.
   - Use const where possible.

4. Tests
   - File: test/footer_responsive_test.dart
   - Widget tests:
     - Render Footer inside a constrained MediaQuery or SizedBox at widths: 360, 768, 1366 and assert layout (e.g., that root is Column for mobile, Row with 3 children for desktop).
   - Recommend golden tests or screenshot comparisons for the three widths.

5. Accessibility & behavior
   - Add semantic labels for TextField and Subscribe button.
   - Ensure focus behavior: subscribe clears text; optionally retain focus behavior consistent per platform.

6. QA checklist (manual)
   - Run app in mobile emulator, portrait and landscape. Confirm stacking and spacing.
   - Open app in desktop browser at large width. Confirm 3-column layout, no overflow, and email keyboard focus/clearing.
   - Verify no overflow exceptions in debug output.

7. Docs & maintenance
   - Add README comment at top of lib/responsive.dart explaining breakpoint constants and how to change them.
   - Keep helpers small and generic for reuse across the app.

## Implementation notes & constraints
- Use only Flutter stable APIs: LayoutBuilder, MediaQuery, OrientationBuilder, Flex widgets, semantic widgets.
- Avoid platform-specific plugins.
- Keep changes minimal and isolated to responsive layer and footer.
- Favor const constructors and small rebuilds.
- Use sample style tokens for font sizes and padding per breakpoint:
  - Mobile: baseFont 14, padding 12
  - Desktop: baseFont 16, padding 20

## Example file map (to create/modify)
- Modify: lib/footer.dart
- Add: lib/responsive.dart
- Add tests: test/footer_responsive_test.dart

## Test scenarios (explicit)
- Widget test: Footer renders a Column at width=360 and contains three vertical sections in order (Opening hours, Help and Information, Subscription).
- Widget test: Footer renders a Row at width=1366 with three children (Left, Middle, Right).
- Interaction test: Enter text in email field, tap Subscribe => field is cleared.

## Minimal acceptance checklist for CI
- All tests pass.
- No overflow exceptions in debug runs for tested widths.
- README comment present describing breakpoints.

## Handover notes
- Keep changes limited to files above.
- Provide short code comments where breakpoints are defined.
- If additional screens require responsive behavior, reuse lib/responsive.dart helpers.

End of requirements.

# Responsive Header — Detailed Requirements

Summary
---
Convert the existing Header widget so that on narrow/mobile screens it no longer renders the full inline menu (causes overflow). Instead, show a compact header with a menu icon that opens a Drawer. Desktop/tablet keep the existing inline header (dropdowns + buttons).

User stories
---
- As a mobile user, I want a compact header and a Drawer menu so the header never overflows and navigation is usable on small screens.
  - Acceptance: On small widths tapping the menu icon opens a Drawer containing all navigation. No overflow occurs.
- As a user, I want the Shop and Print menus to be expandable sublists in the Drawer so I can browse categories easily.
  - Acceptance: Drawer shows ExpansionTiles for Shop and Print with items from _shopText and _printText; tapping an item navigates.
- As a user, I want quick access to Home, About and SALE! from the Drawer as normal buttons.
  - Acceptance: Drawer contains ListTiles for Home, SALE!, About that navigate to their routes.
- As a desktop user, I want the existing header layout to remain unchanged.
  - Acceptance: On wide widths the header still shows DropdownButtons and inline icons.

Breakpoints / Detection
---
- Use MediaQuery or LayoutBuilder to detect mobile:
  - Default breakpoint: width < 600 logical pixels = mobile. Make breakpoint easily configurable if needed.
- Behavior:
  - width < 600: compact header with menu IconButton that opens Drawer.
  - width >= 600: current desktop header layout (unchanged).

Drawer structure and behavior
---
- Parent Scaffold: add drawer: Drawer(...) containing the menu. The page(s) using Header must pass a Scaffold that includes this drawer.
- Header:
  - On mobile show an AppBar-like Row: leading IconButton(icon: Icons.menu) -> open drawer (Scaffold.of(context).openDrawer()) and the same logo (tap navigates home).
  - Keep other top-row elements minimal to avoid overflow (e.g., optional small icons).
- Drawer content (ListView):
  - DrawerHeader or equivalent at top with logo and optional subtitle.
  - Primary ListTile entries:
    - Home -> call navigateToHome(context)
    - SALE! -> call navigateToAbout(context) (or dedicated sale route if exists)
    - About -> call navigateToAbout(context)
  - ExpansionTile: "Shop"
    - children: one ListTile per value in Header._shopText (skip heading item if it is the title like 'shop' if needed).
    - Tapping a ListTile should close Drawer then navigate: Navigator.pop(context); navigateToProduct(context) (or route appropriate to the item).
  - ExpansionTile: "Print"
    - children: one ListTile per value in Header._printText.
    - Tapping closes Drawer then navigates to the print/product route.
  - Footer (optional): small IconButtons or ListTiles for Search, Account, Cart, that call placeholderCallbackForButtons or real handlers.
- Drawer UX:
  - Always close the Drawer before navigation (Navigator.pop(context) then call navigation function).
  - Use ExpansionTile for collapsible lists.
  - Make ListTiles accessible (semantic labels, tap targets >= 48dp).

Navigation preservation
---
- Reuse existing navigateToHome, navigateToProduct, navigateToAbout functions in Header.
- If a specific shop/print item requires a different route or parameter, extend navigateToProduct or add a new navigation helper that accepts an identifier.
- Ensure routes and navigation behavior remain consistent across mobile and desktop.

Desktop behavior / backward compatibility
---
- Desktop/tablet: keep DropdownButton behavior and inline navigation unchanged.
- No Drawer should be shown automatically on wide screens (drawer remains available only if the page's Scaffold has it, but Header must not render the menu icon for wide screens).

Implementation notes / developer hints
---
- Add the Drawer to the Scaffold that renders Header. Example structure:
  - Scaffold(
      drawer: MyHeaderDrawer(...),
      body: Column(children: [Header(), ...])
    )
- In Header.build:
  - if (MediaQuery.of(context).size.width < 600) return mobile header Row; else return existing header Container.
- Implement a small helper widget/function for the Drawer contents (e.g., HeaderDrawer) to keep Header small.
- When creating ListTile onTap:
  - onTap: () { Navigator.pop(context); navigateToHome(context); }
- For Shop/Print tiles if navigation should vary with item:
  - onTap: () { Navigator.pop(context); navigateToProductWithId(context, idOrName); }
- Keep existing errorBuilder for logo image and keep the top sale banner unchanged.

Non-functional requirements
---
- Accessibility: all tappable items have tooltips/semantic labels. ExpansionTiles announce expanded state.
- Performance: Drawer build should be cheap; reuse _shopText/_printText lists.
- Styling: match existing header colors and text styles. Maintain visual hierarchy and spacing consistent with current header.

Edge cases / additional considerations
---
- Landscape phone: still use mobile layout if width < breakpoint.
- Very narrow devices: ensure Drawer content is scrollable (ListView) and no overflow.
- Tablet near breakpoint: consider raising breakpoint if target devices still overflow (configurable).
- If some drawer items need parameters (e.g., different product pages), update navigation helpers accordingly.

Acceptance criteria (done checklist)
---
- [ ] Header does not overflow on mobile device widths (<600).
- [ ] Mobile header shows menu icon and logo only; tapping menu opens Drawer.
- [ ] Drawer includes:
  - [ ] Home, SALE!, About as ListTiles that navigate and close Drawer.
  - [ ] Shop ExpansionTile with each _shopText entry as a ListTile that closes Drawer and navigates.
  - [ ] Print ExpansionTile with each _printText entry as a ListTile that closes Drawer and navigates.
  - [ ] Search/Account/Cart icons available either as AppBar actions or in Drawer footer.
- [ ] Desktop/tablet header is unchanged (inline dropdowns + inline buttons work as before).
- [ ] Drawer closes before navigation and navigation targets are identical to desktop.
- [ ] Tappable targets meet accessibility guidelines (size/labels).
- [ ] Manual test on a phone emulator: open/close Drawer, expand Shop/Print, tap entries — navigation occurs and header no longer overflows.

Deliverables
---
- Modified Header widget: renders mobile/desktop variants.
- New Drawer widget or Drawer contents added to the parent Scaffold.
- Small documentation/update in the code comments describing the breakpoint and how to customize it.

END OF REQUIREMENTS
# Product Page — Responsive Requirements

Version: 1.0  
Target: Flutter (web + Android + iOS) — focus: mobile and web/desktop

Summary
- Make lib/product_page.dart responsive so the product image sits on the left of the page body (excluding header & footer) and product details sit to the right on wide viewports. On mobile the page stacks vertically. Reuse existing responsive helpers (lib/responsive.dart). Preserve existing Header and Footer behavior.

Goals
- Usable, readable product layout on phone and desktop/web.
- Prevent RenderFlex overflow and horizontal scrolling.
- Maintain accessible controls and keyboard navigation.
- Provide automated widget tests covering representative widths.

Breakpoints (configurable in lib/responsive.dart)
- Mobile: width < 600 px
- Desktop/Web: width >= 600 px

Layout requirements
- Global
  - Header and Footer remain unchanged; responsive behavior applies only to the product body between them.
  - The main product body is a two-column layout on desktop/web and a single stacked column on mobile.
  - The product image column must be positioned to the left of the details column for desktop/web.
- Desktop/Web (>=600 px)
  - Left column: product image (primary), thumbnails underneath or below image.
    - Image scales responsively, maintains aspect ratio (recommend AspectRatio or BoxFit.contain).
    - Provide a sensible maxWidth for image column (e.g., 45%–55% of width) but do not use fixed pixel widths.
  - Right column: product title, prices, tax text, attribute controls (Color, Size), Quantity control, Add to Cart / Buy buttons, related items or additional info.
  - Controls layout: allow two-column grouping within details (e.g., attribute selectors + quantity), but ensure no fixed widths that cause overflow.
- Mobile (<600 px)
  - Single-column stacked flow: image, thumbnails, title, price, attributes, quantity, add-to-cart buttons, description.
  - Larger vertical spacing and readable fonts for touch.
  - No horizontal scroll at any point.

Component specifics
- Image
  - Keep aspect ratio and center-cropped or contained behavior.
  - Min touch/visibility area: on mobile allow thumbnails to be tappable with min target 44×44 dp.
- Attribute controls (Color, Size)
  - Use DropdownButton/DropdownMenu with adaptive width: expand to available width but respect a minWidth (>= 120 px or min touch target).
  - Controls should not use hard-coded widths; prefer Expanded/Flexible wrappers.
- Quantity control
  - Use accessible +/- buttons and numeric display; buttons min 36–44 dp.
- Primary actions
  - Add to Cart and secondary payment buttons: full-width on mobile; constrained width on desktop but visible and aligned.
- Text & wrapping
  - Allow wrapping; avoid hard truncation unless intentionally set.
  - Ensure discount/strike-through prices render without causing overflow.

Accessibility
- All interactive elements must be keyboard focusable and reachable in a logical order.
- Provide semantic labels for icons, images (alt text), and form controls.
- Ensure color contrast meets WCAG AA for body text and controls.
- Provide focus visuals for keyboard navigation.
- Ensure dropdowns, quantity, and Add to Cart work with keyboard and Enter/Space activation.

Behavior & interactions
- Header must continue to work without requiring page Scaffolds to supply a drawer (header already opens modal drawer).
- Controls share the same behavior across platforms (web and mobile).
- Text fields / dropdown clear and focus behavior should be correct on web and mobile.

Automated tests (deliverables)
- New tests file: test/product_page_responsive_test.dart
- Tests (use tester.binding.setSurfaceSize and restore in tearDown)
  1. Mobile (360 × 800)
     - Render ProductPage
     - Assert menu icon present (Header mobile), product image displayed above details, stacked layout (no side-by-side), find key elements (title, price, Add to Cart).
     - Assert no RenderFlex overflow (tester.takeException() is null after pumpAndSettle).
  2. Intermediate desktop (768 × 900)
     - Render ProductPage
     - Assert two-column layout: image column on left and details column on right (finders can check for a left-side image widget and a right-side details widget).
     - Assert controls visible and no overflow.
  3. Wide desktop (1366 × 900)
     - Render ProductPage
     - Assert desktop layout persists (left image, right details, optional right-most related column if implemented), inputs expand to available width but respect minimums, no overflow.
- Tests must:
  - Use pumpAndSettle; check tester.takeException() == null for overflow detection.
  - Not rely on fragile widget tree internals (prefer semantic/finders by text, icon, or keys).
  - Restore surface size in tearDown.

Deliverables (concrete)
- Modified file: lib/product_page.dart
  - Implement responsive layout using MediaQuery/LayoutBuilder or Responsive helper.
  - Left image column for desktop; stacked column for mobile.
  - Use Flexible/Expanded/ConstrainedBox/AspectRatio to avoid overflow.
- Tests: test/product_page_responsive_test.dart (three tests described above).
- (Optional) Minor updates to lib/responsive.dart to expose isMobile/isDesktop helpers or adjust breakpoints; document changes.
- Short README or test comment with run instructions.

Acceptance / success criteria (testable)
- Widget tests pass on CI for the three widths.
- No RenderFlex overflow exceptions at 360/768/1366 in tests.
- On mobile: stacked layout, no horizontal scroll, touch targets >= 44 dp.
- On desktop: left image column visible to left of details, controls aligned, inputs expand but respect minWidth.
- Keyboard navigation reaches controls in logical order and buttons are activatable by Enter/Space.

Non-goals / constraints
- Do not redesign Header or Footer components; they must remain present.
- Avoid changing app routes or overall visual language.
- Prefer minimal, well-documented code changes confined to product_page.dart and tests.
- Do not introduce heavy third-party layout packages.

Implementation notes & tips
- Use LayoutBuilder for breakpoint-based branch (check constraints.maxWidth).
- For desktop layout, consider a Row with two Flexible children: left (Flex 1), right (Flex 1.2) — avoid fixed pixel widths.
- For mobile, ensure SingleChildScrollView wrapping prevents vertical clipping; avoid Expanded inside unbounded vertical contexts.
- Use Keys on main sections (e.g., Key('productImage'), Key('productDetails')) to simplify tests.
- Detect overflow in tests via tester.takeException() and widget tree assertions.

How to run tests (PowerShell)
- Single file:
  flutter test test/product_page_responsive_test.dart
- Full test suite:
  flutter test

Example assertions to include in tests
- expect(find.byKey(const Key('productImage')), findsOneWidget)
- expect(find.byKey(const Key('productDetails')), findsOneWidget)
- expect(tester.takeException(), isNull)

Acceptance sign-off
- Provide PR/patch with modified lib/product_page.dart, test file, and a brief commit message describing the change and how to run the tests.

Attached visual reference
- Use the provided screenshot as the desktop layout guide: image on the left, details on the right, thumbnails under main image, primary actions grouped in details column.