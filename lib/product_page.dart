import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/helper_widgets.dart';
import 'package:union_shop/responsive.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  final List<DropdownMenuEntry<String>> colourItems = const [
    DropdownMenuEntry(value: 'red', label: 'Red'),
    DropdownMenuEntry(value: 'blue', label: 'Blue'),
    DropdownMenuEntry(value: 'green', label: 'Green'),
  ];

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final isMobileView = isMobile(context);

    Widget imageColumn = ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 800),
      child: Column(
        key: const Key('productImage'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                testUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Image unavailable',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    Widget detailsColumn = Container(
      key: const Key('productDetails'),
      // use padding and flexible constraints from parent Row/Flex
      // to avoid providing Flex parent data here
      child: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Placeholder Product Name',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '£15.00',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Colour'),
            // Make dropdowns expand but not overflow
            DropdownMenu(
              width: double.infinity,
              dropdownMenuEntries: colourItems,
              initialSelection: 'red',
            ),
            const SizedBox(height: 12),
            // Size and Quantity placed in a single row so quantity appears
            // next to size on both mobile and desktop.
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Size expands to take remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Size'),
                      // Fixed control height so Quantity can match it
                      SizedBox(
                        height: 48,
                        child: DropdownMenu(
                          width: double.infinity,
                          initialSelection: 's',
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 's', label: 'S'),
                            DropdownMenuEntry(value: 'm', label: 'M'),
                            DropdownMenuEntry(value: 'l', label: 'L'),
                            DropdownMenuEntry(value: 'xl', label: 'XL'),
                            DropdownMenuEntry(value: 'xxl', label: 'XXL'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12),

                // Quantity uses a flexible container with a max width so it can
                // shrink on narrow screens and avoid overflow.
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity'),
                      SizedBox(height: 8),
                      // Match the height of the Size control, but keep width compact
                      SizedBox(
                        width: 120,
                        height: 48,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobileView ? double.infinity : 220,
              child: ElevatedButton(
                onPressed: placeholderCallbackForButtons,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a placeholder description for the product. Students should replace this with real product information and implement proper data management.',
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // Mobile: include header and footer inside the scrollable page so they
        // scroll with the content as requested.
        if (isMobileView) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imageColumn,
                ),
                detailsColumn,
                const Footer(),
              ],
            ),
          );
        }

        // Desktop / web: make the entire page (header, body, footer) scrollable
        return SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(flex: 5, child: imageColumn),
                    const SizedBox(width: 24),
                    Flexible(flex: 6, child: detailsColumn),
                  ],
                ),
              ),
              const Footer(),
            ],
          ),
        );
      }),
    );
  }
}
