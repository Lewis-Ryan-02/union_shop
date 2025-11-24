import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 12),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('About Us',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text('Welcome to the Union Shop!'),
                      ),
                      Text(
                          "We're dedicated to giving you the very best University branded products, with a range of clothing and merchandise avaliable to shop all year round! We even offer an exclusive"),
                      Text('personalisation service!',
                          style: TextStyle(decoration: TextDecoration.underline)),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text(
                            "All online purchases are avalible for dilivery or instore collection!"),
                      ),
                      Text(
                          "We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact us at hello@upsu.net."),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text("Happy shopping!"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text("The Union Shop & Reception Team"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
