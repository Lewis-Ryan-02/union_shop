# LLM Prompt — Make Flutter UI responsive across web, tablet and phone

Goal: Implement a responsive UI for the app so layouts adapt cleanly across phone, tablet and web/desktop. Deliver code and tests that make the current footer and other key screens switch between compact vertical layouts on small screens and multi-column/row layouts on larger screens.

Context to give the LLM:
- Project: Flutter app targeting web and mobile (Android/iOS).
- Current problematic widget: Footer (lib/footer.dart) built as a fixed Row with fixed widths.
- Tech constraints: Use Flutter stable APIs (LayoutBuilder, MediaQuery, OrientationBuilder, Responsive widgets pattern). Keep accessibility and keyboard focus for web forms. Avoid platform-specific packages unless necessary.

Feature description:
- Replace hard-coded row/column layout with responsive layout that:
  - Detects screen width and orientation.
  - Uses breakpoints (suggested: mobile <600px, tablet 600–1024px, desktop >=1024px) but parameterizable.
  - Switches footer from horizontal multi-column layout on tablet/desktop to stacked vertical layout on phones.
  - Adjusts paddings, font sizes, and input/button sizing to remain usable on all viewports.
  - Ensures forms (email subscription) behave correctly on web (keyboard, focus, clear) and mobile.

Purpose:
- Provide consistent usable experience across devices.
- Improve readability, spacing and input usability.
- Prevent overflow/layout breakage on small screens and take advantage of space on large screens.

User stories
1. As a phone user, I want the footer content stacked vertically with readable font sizes and tappable buttons so I can read and interact without horizontal scrolling.
2. As a tablet user, I want a compact multi-column layout that uses available width but keeps elements legible.
3. As a desktop/web user, I want a multi-column footer with comfortable spacing and aligned elements; the email input should show an outline and allow keyboard entry and clearing.
4. As a QA engineer, I want automated widget tests and golden tests that validate layout at common breakpoints (e.g., 360px, 768px, 1366px).

Acceptance criteria (must be testable)
- A responsive Footer widget exists and is used in place of the current footer.
- Breakpoints implemented and configurable. Default breakpoints: mobile <600, tablet 600–1024, desktop >=1024.
- Layout behavior:
  - Mobile: footer stacks sections in a single column; each section takes full width with increased vertical spacing.
  - Tablet: footer shows 2 columns if helpful (e.g., left and middle stack, right column for subscription) with balanced spacing.
  - Desktop: footer shows 3 columns in a row with the same content as before but without fixed widths.
- Visual checks:
  - No overflow or pixel overflow errors at any breakpoint.
  - Text does not truncate unexpectedly; long text wraps.
  - Email TextField expands to available width but maintains minimum touch target size.
- Interaction checks:
  - Subscribe button clears the email field and maintains focus behavior expected per platform.
  - On web, the TextField accepts keyboard input and can be focused/cleared.
- Tests:
  - Include at least 1 widget test per breakpoint asserting presence/arrangement of section widgets (e.g., Column vs Row).
  - Include golden tests or screenshot assertions for mobile, tablet, desktop widths.
- Documentation:
  - Brief README or comment describing breakpoints and how to tweak them.
- Backwards compatibility:
  - Non-breaking change to other UI; existing imports remain valid.

Subtasks (deliverables)
1. Design & spec
   - Provide the responsive strategy and breakpoints in code comments.
   - Example sizing scale (font sizes, paddings) for each breakpoint.

2. Implement responsive Footer widget
   - Replace fixed SizedBox widths with percentage or flexible constraints using LayoutBuilder and Flex widgets.
   - Use helper ResponsiveLayout widget or functions to select layouts based on maxWidth.

3. Implement reusable helpers
   - Add a small utility class/file (e.g., lib/responsive.dart) exposing:
     - isMobile, isTablet, isDesktop helpers.
     - breakpoint constants.

4. Ensure accessibility & keyboard behaviour
   - Make TextField keyboard-friendly on mobile and web.
   - Provide semantic labels where appropriate.

5. Tests
   - Widget tests asserting layout type and widget arrangement for 360px, 768px, 1366px.
   - Golden tests (recommended) or screenshot tests for the 3 breakpoints.

6. Manual QA checklist
   - Load app in mobile emulator (portrait & landscape) and verify stacking and spacing.
   - Load in tablet emulator and desktop browser, verify 2/3 column layouts, no overflow.
   - Test keyboard focus and subscribe button on desktop and mobile.

7. Code review notes
   - Keep style consistent with project (prefer const where possible).
   - Avoid large rebuilds; keep widget tree efficient.
   - Make breakpoints configurable for future adjustment.

Example prompt to pass to the coding LLM (put this entire text into the LLM input):
- Summarize the above context and then:
  1. Create lib/responsive.dart with breakpoint helpers.
  2. Modify lib/footer.dart to use LayoutBuilder and responsive helpers to produce mobile/tablet/desktop layouts as described.
  3. Add widget tests under test/footer_responsive_test.dart to assert layout arrangements at widths 360, 768, 1366.
  4. Provide short README comment showing how to adjust breakpoints.
  5. Return only changed/new files in full, with code blocks and file path comments.

Constraints:
- Use only Flutter stable API (no platform-specific plugins).
- Keep changes minimal and isolated to responsive layer and footer.
- Keep code compact and use const constructors where possible.

End of prompt.