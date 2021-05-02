import 'package:flutter/material.dart';

class Forecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          Text(
            '12:00',
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            "assets/images/cloudy.png",
            width: 65.0,
            height: 58.0,
          ),
          Text(
            '13°',
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
