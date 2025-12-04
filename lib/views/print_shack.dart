import 'package:flutter/material.dart';
import 'package:union_shop/widgets/responsive.dart';
import 'package:union_shop/widgets/helper_widgets.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/cart/cart_service.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  int numberOfLines = 1;

  final List<String> prices = ['£15.00', '£25.00', '£30.00'];

  final List<DropdownMenuEntry<String>> lineItems = [
    const DropdownMenuEntry(value: 'one', label: 'One line'),
    const DropdownMenuEntry(value: 'two', label: 'Two lines'),
    const DropdownMenuEntry(value: 'three', label: 'Three lines'),
  ];

  final TextEditingController quantityController =
      TextEditingController(text: '1');

  void updateNumberOfLines(String? value) {
    setState(() {
      switch (value) {
        case 'one':
          numberOfLines = 1;
          break;
        case 'two':
          numberOfLines = 2;
          break;
        case 'three':
          numberOfLines = 3;
          break;
        default:
          numberOfLines = 1;
      }
    });
  }

  List<Widget> buildTextFeildsForLines() {
    List<Widget> textFields = [];
    for (int i = 0; i < numberOfLines; i++) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Line ${i + 1}',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      );
    }
    return textFields;
  }

  void placeholderCallbackForButtons() {
    // Placeholder function for button callbacks
  }

  void addToCart(BuildContext context) {
    final cart = Provider.of<CartService>(context, listen: false);
    int qty = int.tryParse(quantityController.text) ?? 1;
    if (qty < 1) qty = 1;
    final priceStr =
        prices[numberOfLines - 1].replaceAll('£', '').replaceAll(',', '');
    final unitPrice = double.tryParse(priceStr) ?? 0.0;

    cart.addItem(
      productId: 'print_shack_custom',
      name: 'Custom Print Shack Product',
      unitPrice: unitPrice,
      quantity: qty,
      attributes: {'lines': numberOfLines.toString()},
      imageUrl: null,
      metadata: {'source': 'print_shack'},
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Added $qty × Custom Print Shack product to cart'),
    ));
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
              'Make your Own Print Shack Product',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              prices[0],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Number of lines'),
            // Make dropdowns expand but not overflow
            DropdownMenu(
              width: double.infinity,
              dropdownMenuEntries: lineItems,
              initialSelection: lineItems.first.value,
              onSelected: updateNumberOfLines,
            ),
            const SizedBox(height: 12),
            // Stack the text line fields, then place Quantity below them
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the dynamic text fields for lines
                ...buildTextFeildsForLines(),
                const SizedBox(height: 12),

                // Quantity moved below the text fields so it stacks on all sizes
                const Text('Quantity'),
                const SizedBox(height: 8),
                SizedBox(
                  width: isMobileView ? double.infinity : 120,
                  height: 48,
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobileView ? double.infinity : 220,
              child: ElevatedButton(
                onPressed: () => addToCart(context),
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
              '£15.00 for one line, £25.00 for two lines, £30.00 for three lines. Personalise your product with custom text printed in high quality. Choose your colour, size, and quantity above, then add to cart to proceed with your order. Perfect for gifts, events, or personal use!',
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
