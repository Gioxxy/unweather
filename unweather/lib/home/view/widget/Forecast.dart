import 'package:flutter/material.dart';
import 'package:unweather/home/viewModel/ForecastViewModel.dart';

class Forecast extends StatelessWidget {

  ForecastViewModel viewModel;

  Forecast({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          Text(
            viewModel.topText,
            style: TextStyle(
              fontFamily: 'Avenir Next',
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            viewModel.iconName,
            width: 65.0,
            height: 58.0,
          ),
          Text(
            viewModel.bottomText,
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
