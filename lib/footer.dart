import 'package:flutter/material.dart';
import 'responsive.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Widget _sectionLeft(TextStyle textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Opening hours',
            key: const Key('footer_section_left_title'),
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text('PLEASE NOTE THE UNION SHOP WILL BE CLOSED ALL DAY ON 07/11/2025',
            style: textStyle, softWrap: true, overflow: TextOverflow.visible),
        const SizedBox(height: 6),
        Text('(Term Time)', style: textStyle),
        Text('Monday - Friday 9am - 4pm', style: textStyle),
        const SizedBox(height: 6),
        Text('(Outside of Term Time/ Consolidation Weeks)', style: textStyle),
        Text('Monday - Friday 10am - 3pm', style: textStyle),
        const SizedBox(height: 6),
        Text('Purchase online 24/7', style: textStyle),
      ],
    );
  }

  Widget _sectionMiddle(TextStyle textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Help and Information',
            key: const Key('footer_section_middle_title'),
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text('Search', style: textStyle),
        const SizedBox(height: 4),
        Text('Terms and Conditions of Sale Policy',
            style: textStyle, softWrap: true),
      ],
    );
  }

  Widget _sectionRight(
      BuildContext context, bool desktop, TextStyle textStyle) {
    // On desktop the email field should have a reasonable min width for touch.
    const double desktopFieldWidth = 280.0;

    final emailField = Semantics(
      label: 'Email address',
      hint: 'Enter your email to subscribe',
      textField: true,
      child: TextField(
        key: const Key('footer_email_field'),
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Email address',
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
      ),
    );

    final subscribeButton = Semantics(
      button: true,
      label: 'Subscribe',
      child: ElevatedButton(
        key: const Key('footer_subscribe_button'),
        onPressed: () {
          _emailController.clear();
          // Keep focus behaviour simple: do not force unfocus.
          setState(() {});
        },
        child: const Text('Subscribe'),
      ),
    );

    if (desktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subscribe',
              key: const Key('footer_section_right_title'),
              style: textStyle.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          SizedBox(width: desktopFieldWidth, child: emailField),
          const SizedBox(height: 8),
          subscribeButton,
        ],
      );
    }

    // Mobile layout: put the email field and button on a single row so the
    // subscribe button remains visible without vertical space constraints.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subscribe',
            key: const Key('footer_section_right_title'),
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: emailField),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 88, minHeight: 40),
              child: subscribeButton,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool mobile = constraints.maxWidth < MOBILE_MAX;
      const TextStyle mobileStyle =
          TextStyle(fontSize: 14, color: Colors.black87);
      const TextStyle desktopStyle =
          TextStyle(fontSize: 16, color: Colors.black87);
      final textStyle = mobile ? mobileStyle : desktopStyle;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(mobile ? 12.0 : 20.0),
        color: Colors.white54,
        child: mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLeft(textStyle),
                  const SizedBox(height: 16),
                  _sectionMiddle(textStyle),
                  const SizedBox(height: 16),
                  _sectionRight(context, false, textStyle),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _sectionLeft(textStyle)),
                  const SizedBox(width: 20),
                  Expanded(child: _sectionMiddle(textStyle)),
                  const SizedBox(width: 20),
                  Expanded(child: _sectionRight(context, true, textStyle)),
                ],
              ),
      );
    });
  }
}
