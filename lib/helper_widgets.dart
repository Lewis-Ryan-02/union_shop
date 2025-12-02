import 'package:flutter/material.dart';
import 'package:union_shop/responsive.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';

const String testUrl = 'assets/images/placeholder_image.png';

class IfWidget extends StatelessWidget {
  final Widget isTrue;
  final Widget? isFalse;
  final bool condition;

  const IfWidget(
      {super.key, required this.isTrue, this.isFalse, required this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? isTrue : (isFalse ?? const SizedBox.shrink());
  }
}

class ProductOverlay extends StatelessWidget {
  const ProductOverlay(
      {super.key,
      required this.imageUrl,
      required this.title,
      this.path = '/product'});

  final String title;
  final String imageUrl;
  final String path;

  void navigateToPath(BuildContext context) {
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => navigateToPath(context),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                      imageUrl,
                    ).image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            // Content overlay
            Positioned(
              left: 24,
              right: 24,
              top: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ));
  }
}

class ProductSection extends StatelessWidget {
  const ProductSection(
      {super.key,
      required this.title,
      required this.children,
      this.mobileCount = 1,
      this.desktopCount = 2,
      this.crossSpacing = 24,
      this.mainSpacing = 48});

  final String title;
  final List<Widget> children;
  final int mobileCount;
  final int desktopCount;
  final double crossSpacing;
  final double mainSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop(context) ? desktopCount : mobileCount,
              crossAxisSpacing: crossSpacing,
              mainAxisSpacing: mainSpacing,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final String path;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.path = '/product',
    this.discountPrice = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              IfWidget(
                  isFalse: Text(
                    price,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  isTrue: Row(
                    children: [
                      Text(
                        discountPrice,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  condition: discountPrice.isNotEmpty),
            ],
          ),
        ],
      ),
    );
  }
}

class CollectionItemPage extends StatelessWidget {
  const CollectionItemPage(
      {super.key, required this.title, required this.children});

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Header(),
        title,
        const Divider(),
        // Use Wrap so filter/sort controls flow to the next line on narrow
        // viewports instead of causing a horizontal RenderFlex overflow.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            const Text('Filter by: '),
            // Constrain dropdown widths so they can't demand too much space
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isMobile(context) ? 200 : 300),
              child: DropdownButton<String>(
                isDense: isMobile(context),
                isExpanded: true,
                value: 'All Products',
                items: const [
                  DropdownMenuItem(
                      value: 'All Products', child: Text('All Products')),
                  DropdownMenuItem(
                      value: 'Merchandise', child: Text('Merchandise')),
                ],
                onChanged: (String? newValue) {},
                hint: const Text('Filter'),
              ),
            ),
            const Text('Sort by: '),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isMobile(context) ? 200 : 300),
              child: DropdownButton<String>(
                isDense: isMobile(context),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'Featured', child: Text('Featured')),
                  DropdownMenuItem(
                      value: 'Best Selling', child: Text('Best Selling')),
                  DropdownMenuItem(
                      value: 'Alphabetical A-Z',
                      child: Text('Alphabetical A-Z')),
                  DropdownMenuItem(
                      value: 'Alphabetical Z-A',
                      child: Text('Alphabetical Z-A')),
                  DropdownMenuItem(
                      value: 'Price: Low to High',
                      child: Text('Price: Low to High')),
                  DropdownMenuItem(
                      value: 'Price: High to Low',
                      child: Text('Price: High to Low')),
                  DropdownMenuItem(
                      value: 'Date old to new', child: Text('Date old to new')),
                  DropdownMenuItem(
                      value: 'Date new to old', child: Text('Date new to old')),
                ],
                onChanged: (String? newValue) {},
                hint: const Text('Sort'),
              ),
            ),
            IfWidget(
                isTrue: Text('${children.length} products'),
                condition: isDesktop(context)),
          ],
        ),
        const Divider(),
        IfWidget(
            isTrue: Text('${children.length} products'),
            condition: isMobile(context)),
        ProductSection(
            title: '', desktopCount: 3, mobileCount: 2, children: children),
        const Footer(),
      ],
    )));
  }
}
