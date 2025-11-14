import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({super.key});
  final TextEditingController emailField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Colors.white54,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('Opening hours')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text(
                            'PLEASE NOTE THE UNION SHOP WILL BE CLOSED ALL DAY ON 07/11/2025')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('(Term Time)')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('Monday - Friday 9am - 4pm')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text(
                            '(Outside of Term Time/ Consolidation Weeks)')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('Monday - Friday 10am - 3pm')),
                    Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('Purchase online 24/7')),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const SizedBox(
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text('Help and Information')),
                      Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text('Search')),
                      Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text('Terms and Conditions of Sale Policy')),
                    ],
                  )),
              const SizedBox(width: 20),
              SizedBox(
                  width: 140,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: TextField(
                              controller: emailField,
                              decoration: const InputDecoration(
                                  hintText: 'Email address',
                                  border: OutlineInputBorder()),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: ElevatedButton(
                                onPressed: () => emailField.clear(),
                                child: const Text('Subscribe'))),
                      ])),
            ]));
  }
}
