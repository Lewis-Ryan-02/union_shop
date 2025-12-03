import 'package:flutter/material.dart';

/// Drawer used for mobile navigation. Contains primary navigation entries
/// and expansion tiles for Shop and Print categories.
class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({super.key});

  static const List<String> _shopText = [
    'Signatures range',
    'Portsmouth City Collection',
    'Graduation'
  ];

  static const List<String> _paths = [
    '/collections/signature-range',
    '/collections/portsmouth-city',
    '/collections/graduation'
  ];

  static const List<String> _printText = [
    'The print shack',
    'About',
    'Personalisation'
  ];

  static const List<String> _printPaths = [
    '/print-shack',
    '/print-shack/about',
    '/print-shack',
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
            ExpansionTile(
              leading: const Icon(Icons.store),
              title: const Text('Shop'),
              children: _shopText
                  .map((s) => ListTile(
                        title: Text(s),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, _paths[_shopText.indexOf(s)]);
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
                          Navigator.pushNamed(
                              context, _printPaths[_printText.indexOf(s)]);
                        },
                      ))
                  .toList(),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('SALE!'),
              onTap: () => _navigateTo(context, '/collections/sale'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => _navigateTo(context, '/about'),
            ),
          ],
        ),
      ),
    );
  }
}
