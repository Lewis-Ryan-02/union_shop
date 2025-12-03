You are an expert Flutter developer and automated engineer. Implement a shopping cart system for a Flutter app. The cart must accept as arguments products and product attributes (e.g., size, color, personalization lines) and expose a clean API for adding, updating, removing items, and computing totals. Work without changing unrelated UI components unless necessary; integrate with the existing app structure and follow its style conventions. Provide tests and documentation with the final deliverables.

Context & constraints
- Platform: Flutter (mobile & web). Use the project's existing state-management pattern if present; if none exists, prefer a modern, testable approach (e.g., Riverpod or Provider) and explain the choice.
- Cart inputs: each cart item must include a product reference and attribute set (product id/sku, name, unit price, quantity, attributes map/object for customizations, optional imageUrl, tax info if applicable).
- Persist cart locally (so it survives app restarts) and expose a serialization format (JSON).
- Do not modify unrelated features or pages; keep changes minimal and reversible.
- Deliver tested, maintainable, and documented code.

Primary goals
- Implement a robust cart model (data + operations).
- Provide a reactive state layer that UI can subscribe to.
- Provide UI components for cart interaction (icon + badge, cart page, mini-cart/modal).
- Persist cart state and provide export/import serialization.
- Provide tests (unit, widget) and a small README with integration steps.

Required inputs (cart item structure — use analogous structures in the app)
- productId (string)
- sku (string | optional)
- name (string)
- unitPrice (decimal/num)
- quantity (int)
- attributes (object/map): e.g., { size: "L", color: "purple", lines: ["Name", "Dept"] }
- imageUrl (string | optional)
- metadata (map | optional) — for vendor, tax class, notes

User stories
1. As a shopper, I can add a product to the cart with specific attributes (size, color, personalization lines), and the cart will record those attributes with the item.
   - Acceptance: after adding, cart contains an item with matching productId and attributes and computed line total = unitPrice * quantity.

2. As a shopper, I can change the quantity of a cart item and see totals update immediately.
   - Acceptance: changing quantity updates line total and overall subtotal; quantity lower bound is 1 (or 0 if you allow removal via 0).

3. As a shopper, I can remove an item from the cart.
   - Acceptance: remove operation deletes the entry and reduces totals accordingly.

4. As a shopper, I can view the cart from an app header icon that shows a badge with the total number of items.
   - Acceptance: badge updates in real-time as items are added/removed/updated.

5. As a shopper, I can view cart details on a cart page with item list, attributes shown, and subtotal/estimated tax/total.
   - Acceptance: cart page shows every attribute, image (if available), unit price, quantity control, line total, and totals section.

6. As a shopper, my cart persists when I close and reopen the app.
   - Acceptance: cart state is restored from local storage on app start.

7. As an engineer, I can serialize the cart to JSON and restore it from that JSON.
   - Acceptance: read/write JSON fixture round-trips without data loss.

8. As an engineer, I can run unit and widget tests that validate the cart's operations and UI bindings.
   - Acceptance: tests for add/update/remove/serialize/restore pass.

Success criteria
- All cart operations are covered by unit tests (add, update quantity, remove, clear, totals calculation).
- Widget tests exist for the cart badge and the cart page rendering (attributes, quantities, totals).
- Cart persists and restores correctly.
- No changes to unrelated pages or functionality.
- Code is documented (README, inline doc comments for public APIs), and integration steps are clear.
- PR-ready: small, focused changes grouped logically with clear commit messages.

Functional requirements
- API (public methods for app code):
  - addItem(Product, attributes, quantity = 1)
  - updateItemQuantity(cartItemId|key, newQuantity)
  - updateItemAttributes(cartItemId|key, attributes)
  - removeItem(cartItemId|key)
  - clearCart()
  - getItems(): List<CartItem>
  - getItemCount(): int (sum of quantities)
  - getSubtotal(): num
  - getTax(rate or per-item): num (support a configurable tax strategy)
  - getTotal(): num
  - serialize(): JSON
  - deserialize(json): restores cart
- Cart item identity: two items with same productId but different attributes must be separate cart items (attribute-aware equality).
- Quantity: integer >= 1; configuration option to allow zero to remove.
- Rounding & currency: total calculations must be precise enough for currency (document rounding strategy).
- Persistence: store serialized cart in local storage (SharedPreferences / local DB) and restore at startup.
- Concurrency: ensure operations are atomic and do not cause race conditions if called concurrently.

UI requirements
- Cart icon with badge in header:
  - Badge shows total quantity (sum of quantities).
  - On tap, opens cart page or mini-cart modal.
- Cart page:
  - List of cart items: thumbnail, name, attributes rendered clearly, unit price, quantity control (increment/decrement or text input), line total, remove button.
  - Totals block: subtotal, optional shipping placeholder, tax, total.
  - Primary call-to-action: "Proceed to Checkout" (stubbed).
- Mini-cart (optional): small overlay showing 3 items and a "View cart" CTA.

Testing requirements
- Unit tests:
  - addItem merges quantities only when productId & attributes are identical.
  - updateItemQuantity enforces bounds and recomputes totals.
  - removeItem clears the right item.
  - serialize/deserialize retains attributes and quantities exactly.
  - totals calculation with multiple items and taxes.
- Widget tests:
  - Cart badge updates when items added/removed/updated.
  - Cart page renders list with attributes, quantity controls functional in tests.
  - Persistence: simulate restart by serializing to JSON, creating new store and deserializing, and then verifying state in a widget test.
- Edge-case tests:
  - Adding items with large quantity and price (check totals).
  - Adding items with many attributes (deep equality).
  - Invalid input (negative quantity) should be rejected or corrected — test behavior.

Non-functional requirements
- Performance: updates to the cart should be near-instant; avoid heavy synchronous disk ops on the UI thread (persist asynchronously).
- Maintainability: small, well-documented modules; clean public interfaces; unit-tested logic.
- Accessibility: quantity buttons must be accessible (semantic labels).
- Internationalization: currency rendering should use existing app locale; don't hardcode currency symbols.

Deliverables
- Implementation files (suggested logical file list; actual filenames up to implementer):
  - cart/models/cart_item.dart (data model)
  - cart/models/cart_totals.dart (subtotal/tax/total)
  - cart/cart_service.dart or cart/provider.dart (state management & API)
  - cart/storage/cart_persistence.dart (serialization + local storage)
  - ui/cart/cart_icon.dart (header icon + badge)
  - ui/cart/cart_page.dart (full cart page)
  - ui/cart/mini_cart.dart (optional)
- Tests:
  - unit tests for cart logic (add/update/remove/serialize)
  - widget tests for badge and cart page
- Documentation:
  - README at `lib/cart/README.md` containing:
    - Integration instructions (how to import and show the cart icon, route to cart page)
    - Public API usage examples (method names and arguments — no code required in the final LLM output if requested)
    - JSON format definition for serialization
    - Testing notes
- Migration notes (if any): where to add initialization code for restore on app start.
- A small demo or test harness page showing cart integration (optional, but recommended).

Acceptance criteria (concrete)
- Unit tests: >= 90% coverage for cart core logic.
- Widget tests: critical UI behaviors covered (badge updates, cart page renders).
- Manual test: add item(s) -> badge updates -> open cart -> change qty/remove -> totals update -> app restart -> cart restored.
- All tests pass: `flutter test` should return success in CI.

Edge cases & considerations (must be handled or documented)
- Items with identical productId but different attribute order should be considered equal only if attribute sets are equal semantically (order-insensitive).
- Items with price changes between adding to cart and checkout: document how price freezes on add-to-cart or how you plan to refresh prices (prefer freezing price in cart item and reconciling at checkout).
- Stock availability: if stock validation is required, provide hooks to validate before checkout (out-of-scope for core cart but include extension points).
- Coupons, shipping calculations, and payment are out-of-scope for core cart, but design extension points for them.

Developer notes for the implementer
- Use dependency injection for storage and optional services so tests can mock persistence.
- Keep business logic (totals, merging, equality) separate from UI for testability.
- Use immutable models or defensively-copied structures for cart items to avoid accidental mutation.
- Persist asynchronously and debounce frequent writes (e.g., quantity spinners).

Success checklist to include with PR
- [ ] Cart model implemented and documented.
- [ ] Reactive cart state provider/service implemented.
- [ ] Cart persistence implemented and restored on app start.
- [ ] Cart icon + badge implemented and integrated into header.
- [ ] Cart page implemented with full item listing and totals.
- [ ] Unit tests for core logic added & green.
- [ ] Widget tests for UI behaviors added & green.
- [ ] README with integration & usage notes added.
- [ ] Clear migration / integration instructions for reviewers.

If anything is ambiguous in the app structure (state management used, routing conventions, where to put header icon), ask a clarifying question before implementing and include rationale in the PR. Prioritize test coverage and a small, well-explained change set.