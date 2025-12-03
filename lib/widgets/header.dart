import 'package:flutter/material.dart';
import 'package:union_shop/widgets/responsive.dart';
import 'package:union_shop/widgets/header_drawer.dart';

class Header extends StatelessWidget {
  const Header({super.key});
  static const List<String> _printText = [
    'The print shack',
    'About',
    'Personalisation'
  ];

  static const List<String> _printPaths = [
    '/print-shack',
    '/print-shack/about',
    '/print-shack/personalisation'
  ];

  static const List<String> _shopText = [
    'Signatures range',
    'Portsmouth City Collection',
    'Graduation'
  ];

  static const List<String> _shopPaths = [
    '/collections/signature-range',
    '/collections/portsmouth-city',
    '/collections/graduation'
  ];

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/signin');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/collections/sale');
  }

  void navigateToGraduation(BuildContext context) {
    Navigator.pushNamed(context, '/collections/graduation');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Main header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(minHeight: 56),
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                // Use the layout constraints here (not the outer context) so the
                // header chooses the mobile/desktop variant based on available
                // width in its parent rather than a possibly different MediaQuery.
                // If the LayoutBuilder provides an infinite maxWidth (common when
                // the parent doesn't constrain width), fall back to the
                // MediaQuery width so tests and real layouts behave the same.
                final double width = constraints.maxWidth.isFinite
                    ? constraints.maxWidth
                    : MediaQuery.of(ctx).size.width;
                final bool mobileVariant = width < mobileMax || isMobile(ctx);

                if (mobileVariant) {
                  return Row(
                    children: [
                      // Logo at the left
                      GestureDetector(
                        onTap: () {
                          navigateToHome(context);
                        },
                        child: Image.network(
                          'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                          height: 24,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              key: const Key('header_error_key_mobile'),
                              color: Colors.grey[300],
                              width: 24,
                              height: 24,
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      // Keep a few action icons accessible on mobile
                      IconButton(
                        tooltip: 'Search',
                        icon: const Icon(Icons.search, color: Colors.grey),
                        padding: const EdgeInsets.all(6),
                        constraints:
                            const BoxConstraints(minWidth: 36, minHeight: 36),
                        onPressed: placeholderCallbackForButtons,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person_outline,
                          size: 18,
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: () => navigateToSignIn(context),
                      ),
                      IconButton(
                        tooltip: 'Cart',
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.grey),
                        padding: const EdgeInsets.all(6),
                        constraints:
                            const BoxConstraints(minWidth: 36, minHeight: 36),
                        onPressed: placeholderCallbackForButtons,
                      ),
                      // Menu on the right — open our modal drawer so pages
                      // don't need to provide a Scaffold drawer.
                      Builder(builder: (ctx) {
                        return IconButton(
                          icon: const Icon(Icons.menu, color: Colors.grey),
                          tooltip: 'Open navigation menu',
                          padding: const EdgeInsets.all(8),
                          constraints:
                              const BoxConstraints(minWidth: 36, minHeight: 36),
                          onPressed: () {
                            final scaffoldState = Scaffold.maybeOf(ctx);
                            try {
                              if (scaffoldState != null &&
                                  scaffoldState.widget.drawer != null) {
                                scaffoldState.openDrawer();
                                return;
                              }
                            } catch (_) {}

                            showModalBottomSheet<void>(
                              context: ctx,
                              isScrollControlled: true,
                              builder: (sheetCtx) => SizedBox(
                                height:
                                    MediaQuery.of(sheetCtx).size.height * 0.8,
                                child: const HeaderDrawer(),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  );
                }

                // Desktop / wide layout
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateToHome(context);
                      },
                      child: Image.network(
                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                        height: 18,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            key: const Key('header_error_key_desktop'),
                            color: Colors.grey[300],
                            width: 18,
                            height: 18,
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateToHome(context);
                            },
                            child: const SizedBox(
                                width: 60, child: Center(child: Text('Home'))),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              value: _shopText[0],
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              onChanged: (String? newValue) {
                                Navigator.pushNamed(
                                    context, _shopPaths[_shopText.indexOf(newValue!)]);
                              },
                              icon: const Icon(Icons.arrow_downward),
                              items: _shopText.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              value: _printText[0],
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              onChanged: (String? newValue) {
                                Navigator.pushNamed(
                                    context, _printPaths[_printText.indexOf(newValue!)]);
                              },
                              icon: const Icon(Icons.arrow_downward),
                              items: _printText.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              navigateToSale(context);
                            },
                            child: const SizedBox(
                                width: 60, child: Center(child: Text('SALE!'))),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              navigateToAbout(context);
                            },
                            child: const SizedBox(
                                width: 60, child: Center(child: Text('About'))),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: placeholderCallbackForButtons,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.person_outline,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: () => navigateToSignIn(context),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: placeholderCallbackForButtons,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
