import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unweather/home/viewModel/ForecastViewModel.dart';

class Forecast extends StatelessWidget {

  final ForecastViewModel viewModel;

  Forecast({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          SizedBox(height: 10,),
          Stack(
            children: [
              /*Image.asset(
                viewModel.iconName,
                width: 50,
                height: 50,
              ),*/
              Opacity(child: Image.asset(viewModel.iconName, color: Colors.black54,
                width: 50,
                height: 50,), opacity: 0.2),
              ClipRect(
                  child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Image.asset(viewModel.iconName,
                    width: 50,
                    height: 50,)))
            ],
          ),
          SizedBox(height: 10,),
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
