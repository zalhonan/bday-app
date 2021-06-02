import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MaterialEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('я карта');
    return Card(
      elevation: 4,
      child: Container(
        height: 100,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.accessibility_new),
              FaIcon(FontAwesomeIcons.airbnb),
              FaIcon(FontAwesomeIcons.infinity),
              Text(
                'Французских 🎂',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Съешь еще этих 🎂',
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Noto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
