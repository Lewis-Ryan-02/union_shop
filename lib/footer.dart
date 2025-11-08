import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Colors.white54,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox( 
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('Opening hours')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('PLEASE NOTE THE UNION SHOP WILL BE CLOSED ALL DAY ON 07/11/2025')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('(Term Time)')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('Monday - Friday 9am - 4pm')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('(Outside of Term Time/ Consolidation Weeks)')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('Monday - Friday 10am - 3pm')),
                  Padding( padding: EdgeInsets.only(bottom: 4.0), child: Text('Purchase online 24/7')),
                ],
            ),
            ),
          ],
        ));
  }
}
