import 'package:flutter/material.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/sign_in_page.dart';
import 'package:union_shop/views/collections.dart';
import 'package:union_shop/views/graduation_page.dart';
import 'package:union_shop/views/sale_page.dart';
import 'package:union_shop/views/home.dart';
import 'package:union_shop/products.dart';
import 'package:union_shop/views/city_page.dart';
import 'package:union_shop/views/signature_page.dart';
import 'package:union_shop/views/print_shack.dart';
import 'package:union_shop/views/print_shack_about.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/about': (context) => const AboutPage(),
        '/signin': (context) => SignInScreen(),
        '/collections': (context) => const CollectionsPage(),
        '/collections/graduation': (context) => const GraduationPage(),
        '/collections/sale': (context) => const SalePage(),
        '/collections/portsmouth-city': (context) => const PortsmouthCityCollectionPage(),
        '/collections/signature-range': (context) => const SignaturePage(),
        '/print-shack': (context) => const PrintShackPage(),
        '/print-shack/about': (context) => const PrintShackAboutPage(),

        TShirtProductPage.path: (context) => const TShirtProductPage(),
        HoodieProductPage.path: (context) => const HoodieProductPage(),
        TeddyBearProductPage.path: (context) => const TeddyBearProductPage(),
        ShoesProductPage.path: (context) => const ShoesProductPage(),

        EssentialTShirtProductPage.path: (context) => const EssentialTShirtProductPage(),
        EssentialHoodieProductPage.path: (context) => const EssentialHoodieProductPage(),
        BeenieProductPage.path: (context) => const BeenieProductPage(),
        JeansProductPage.path: (context) => const JeansProductPage(),

        PostCardProductPage.path: (context) => const PostCardProductPage(),
        BookmarkProductPage.path: (context) => const BookmarkProductPage(),
        MagnetProductPage.path: (context) => const MagnetProductPage(),
        NotebookProductPage.path: (context) => const NotebookProductPage(),        


        SignatureTShirtProductPage.path: (context) => const SignatureTShirtProductPage(),
        SignatureHoodieProductPage.path: (context) => const SignatureHoodieProductPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: const Center(child: Text('404 - Page Not Found')),
        ),
      ),
    );
  }
}
