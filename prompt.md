Goal
---
Make Header responsive: on narrow/mobile screens the header should use a Drawer instead of rendering the full inline menu (to avoid overflow). Desktop/tablet keeps the existing desktop layout (with dropdowns).

Requirements
---
1. Detect "mobile" by screen width (suggestion: MediaQuery.width < 600 or LayoutBuilder breakpoint).
2. On mobile:
   - Replace the inline dropdowns and menu text with a menu icon that opens a Drawer.
   - The parent Scaffold must have the drawer; Header should open it with Scaffold.of(context).openDrawer() (or expose a callback).
3. Drawer structure:
   - Top: same logo + optional user/cart/search icons (or keep icons in AppBar actions).
   - Menu items as ListTile widgets:
     - "Home" -> call existing navigateToHome(context)
     - "SALE!" -> call existing navigateToAbout(context) (or appropriate)
     - "About" -> call existing navigateToAbout(context)
   - Dropdown menus become ExpansionTiles (sublists):
     - "Shop" ExpansionTile: one ListTile per item in Header._shopText; tapping an item navigates (use navigateToProduct or a dedicated route as appropriate).
     - "Print" ExpansionTile: one ListTile per item in Header._printText; tapping an item navigates (navigateToProduct or a route).
   - Keep icons (search, account, bag) as small IconButtons either in the AppBar actions or inside the Drawer footer.
4. Preserve navigation:
   - Keep and reuse existing navigateToHome, navigateToProduct, navigateToAbout functions. Each Drawer item should call those functions (or specific route names).
5. Accessibility & UX:
   - Ensure Drawer closes after a tap (Navigator.pop(context) before navigating, or use pushReplacement/pop patterns).
   - Use ExpansionTile for sublists so submenus are collapsible.
6. Desktop behavior:
   - Keep current DropdownButton behavior for wider widths; do not render the Drawer there.

Acceptance criteria
---
- On mobile widths the header no longer overflows and a menu icon opens a Drawer.
- Drawer contains ExpansionTiles for _shopText and _printText and ListTile buttons for regular items.
- Tapping items navigates to the same pages as before.
- Desktop layout remains unchanged.

Implementation hints (Dart/Flutter)
---
- Wrap the page that uses Header with a Scaffold(drawer: Drawer(...)).
- In Header.build:
  - if (MediaQuery.of(context).size.width < 600) return a compact AppBar-like Row with leading IconButton(onPressed: () => Scaffold.of(context).openDrawer()) and main logo; else return existing desktop Row.
- Drawer: use ListView(children: [DrawerHeader(...), ListTile(title: Text('Home'), onTap: () { Navigator.pop(context); navigateToHome(context); }), ExpansionTile(title: Text('Shop'), children: _shopText.map((s) => ListTile(title: Text(s), onTap: () { Navigator.pop(context); navigateToProduct(context); })).toList()), ... ])
- Ensure you call Navigator.pop(context) before navigation so the drawer closes.

Deliverable
---
A small patch to header.dart (and add drawer to the parent Scaffold) implementing the above responsive behavior and Drawer menu with ExpansionTiles for dropdowns.