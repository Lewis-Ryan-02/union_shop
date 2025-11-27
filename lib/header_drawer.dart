import 'package:flutter/material.dart';

/// Drawer used for mobile navigation. Contains primary navigation entries
/// and expansion tiles for Shop and Print categories.
class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({super.key});

  static const List<String> _shopText = [
    'Clothing',
    'Merchandise',
    'Halloween 🎃',
    'Signatures & Essential range',
    'Portsmouth City Collection',
    'Pride Collection 🏳️‍🌈',
    'Graduation 🎓'
  ];

  static const List<String> _printText = [
    'The print shack',
    'About',
    'Personalisation'
  ];

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  void _navigateHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF4d2963)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Union Shop',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(height: 8),
                  Text('Browse categories',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _navigateHome(context),
              dense: false,
              visualDensity: VisualDensity.compact,
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('SALE!'),
              onTap: () => _navigateTo(context, '/about'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => _navigateTo(context, '/about'),
            ),
            ExpansionTile(
              leading: const Icon(Icons.store),
              title: const Text('Shop'),
              children: _shopText
                  .map((s) => ListTile(
                        title: Text(s),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/product');
                        },
                      ))
                  .toList(),
            ),
            ExpansionTile(
              leading: const Icon(Icons.print),
              title: const Text('Print'),
              children: _printText
                  .map((s) => ListTile(
                        title: Text(s),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/product');
                        },
                      ))
                  .toList(),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: 'Search',
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    tooltip: 'Account',
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    tooltip: 'Cart',
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
