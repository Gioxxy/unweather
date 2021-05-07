import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:unweather/home/HomeManager.dart';
import 'package:unweather/home/model/HomeModel.dart';
import 'package:unweather/home/viewModel/ForecastViewModel.dart';

class HomeViewModel {
  String city;
  String temperature;
  String iconName;
  String day;
  String month;
  String maxTemperature;
  String minTemperature;
  String rain;
  String windSpeed;
  String humidity;
  String visibility;
  String cloudiness;
  String pressure;
  bool isNight;
  List<ForecastViewModel> forecastHours;
  List<ForecastViewModel> forecastDays;

  HomeManager manager;

  HomeViewModel({@required this.manager});

  _setup(HomeModel model){
    city = model.city.name;
    iconName = _getIcon(model.list.first.weather.first.icon);
    temperature = model.list.first.main.temp.round().toString() + "°";
    day = model.list.first.dtTxt.day.toString();
    month = " " + _toTitleCase(DateFormat("MMM", "it_IT").format(model.list.first.dtTxt));
    maxTemperature = "max " + model.list.first.main.tempMax.round().toString() + "°";
    minTemperature = "min " + model.list.first.main.tempMin.round().toString() + "°";
    rain = (model.list.first.rain?.threeH ?? 0).toStringAsFixed(1) + " mm";
    windSpeed = ((model.list.first.wind?.speed ?? 0) * 3.6).toStringAsFixed(1) + " km/h";
    humidity = (model.list.first.main.humidity ?? 0).toString() + "%";
    visibility = ((model.list.first.visibility ?? 0)/1000).toStringAsFixed(1) + " km";
    cloudiness = (model.list.first.clouds.all ?? 0).toString() + "%";
    pressure = (model.list.first.main.pressure ?? 0).toString() + " hPa";
    isNight = false;//model.list.first.sys.pod == "n";

    forecastHours = model.list.map((e){
      return ForecastViewModel(
        topText: DateFormat("HH:mm", "it_IT").format(e.dtTxt),
        iconName: _getIcon(e.weather.first.icon),
        bottomText: e.main.temp.round().toString() + "°"
      );
    }).toList();
    forecastHours.first.topText = "Ora";

    forecastDays = model.list.map((e){
      if(e.dtTxt.hour == 12) {
        return ForecastViewModel(
            topText: _toTitleCase(DateFormat("d MMM", "it_IT").format(e.dtTxt)),
            iconName: _getIcon(e.weather.first.icon),
            bottomText: e.main.temp.round().toString() + "°"
        );
      }
      return null;
    }).where((e) => e != null).toList();
    // forecastDays.first.topText = "Oggi";
  }

  String _getIcon(String cod){
    switch(cod){
      case "01d": { return "assets/images/DClear.png"; } break;
      case "01n": { return "assets/images/NClear.png"; } break;
      case "02d": { return "assets/images/DCloudy.png"; } break;
      case "02n": { return "assets/images/NCloudy.png"; } break;
      case "03d": { return "assets/images/scatteredClouds.png"; } break;
      case "03n": { return "assets/images/scatteredClouds.png"; } break;
      case "04d": { return "assets/images/brokenClouds.png"; } break;
      case "04n": { return "assets/images/brokenClouds.png"; } break;
      case "09d": { return "assets/images/showerRain.png"; } break;
      case "09n": { return "assets/images/showerRain.png"; } break;
      case "10d": { return "assets/images/rain.png"; } break;
      case "10n": { return "assets/images/rain.png"; } break;
      case "11d": { return "assets/images/thunderstorm.png"; } break;
      case "11n": { return "assets/images/thunderstorm.png"; } break;
      case "13d": { return "assets/images/snow.png"; } break;
      case "13n": { return "assets/images/snow.png"; } break;
      case "50d": { return "assets/images/DFog.png"; } break;
      case "50n": { return "assets/images/NFog.png"; } break;
      default: {return "assets/images/DClear.png"; }
    }
  }

  Future<HomeViewModel> featchData({@required String city}) async {
    try {
      _setup(await manager.featchData(city));
      return this;
    } catch(error){
      return Future<HomeViewModel>.error(_toTitleCase(error.message));
    }
  }

  String _toTitleCase(String str) {
    return str
        .replaceAllMapped(
        RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match m) =>
        "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}")
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}