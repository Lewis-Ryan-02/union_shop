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