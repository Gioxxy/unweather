import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:unweather/home/model/HomeModel.dart';
import 'package:unweather/home/viewModel/ForecastViewModel.dart';
import 'package:unweather/utils/Request.dart';
import 'package:unweather/utils/ResponseError.dart';

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

  HomeViewModel();

/*  HomeViewModel({HomeModel model}){
    city = model.city.name;
    temperature = model.list.first.main.temp.round();
    day = model.list.first.dtTxt.day;
    month = DateFormat("MMM", "it_IT").format(model.list.first.dtTxt);
    maxTemperature = model.list.first.main.tempMax.round();
    minTemperature = model.list.first.main.tempMin.round();
    rain = (model.list.first.rain.threeH ?? 0).toString() + " mm";
    windSpeed = (model.list.first.wind.speed ?? 0).toString() + " km/h";
    humidity = (model.list.first.main.humidity ?? 0).toString() + "%";
    visibility = (model.list.first.visibility ?? 0).toString() + " km";
    cloudiness = (model.list.first.clouds.all ?? 0).toString() + "%";
    pressure = (model.list.first.main.pressure ?? 0).toString() + " hPa";
  }*/

  _setup(HomeModel model){
    city = model.city.name;
    temperature = model.list.first.main.temp.round().toString() + "°";
    day = model.list.first.dtTxt.day.toString();
    month = " " + _toTitleCase(DateFormat("MMM", "it_IT").format(model.list.first.dtTxt));
    maxTemperature = "max " + model.list.first.main.tempMax.round().toString() + "°";
    minTemperature = "min " + model.list.first.main.tempMin.round().toString() + "°";
    rain = (model.list.first.rain?.threeH ?? 0).toString() + " mm";
    windSpeed = ((model.list.first.wind?.speed ?? 0) * 3.6).toString() + " km/h";
    humidity = (model.list.first.main.humidity ?? 0).toString() + "%";
    visibility = ((model.list.first.visibility ?? 0)/1000).toString() + " km";
    cloudiness = (model.list.first.clouds.all ?? 0).toString() + "%";
    pressure = (model.list.first.main.pressure ?? 0).toString() + " hPa";
    isNight = model.list.first.sys.pod == "n";

    forecastHours = model.list.map((e){
      return ForecastViewModel(
        topText: DateFormat("HH:mm", "it_IT").format(e.dtTxt),
        iconName: "assets/images/cloudy.png",
        bottomText: e.main.temp.round().toString() + "°"
      );
    }).toList();
    forecastHours.first.topText = "Ora";

    forecastDays = model.list.map((e){
      if(e.dtTxt.hour == 12) {
        return ForecastViewModel(
            topText: _toTitleCase(DateFormat("d MMM", "it_IT").format(e.dtTxt)),
            iconName: "assets/images/cloudy.png",
            bottomText: e.main.temp.round().toString() + "°"
        );
      }
      return null;
    }).where((e) => e != null).toList();
    // forecastDays.first.topText = "Oggi";
  }

  Future<HomeViewModel> featchData() async {
    Completer completer = Completer<HomeViewModel>();
    Request.get(
      route: "/data/2.5/forecast",
      params: {'q': 'Turin', 'units': 'metric', 'lang': 'it'},
      onResponse: (response){
        if(response.statusCode == 200 && response.body["cod"] == "200"){
          HomeModel model = HomeModel.fromJson(response.body);
          _setup(model);
          completer.complete(this);
        } else {
          ResponseError error = ResponseError.serviceConstructor(ResponseErrorType.unspecificated, "Errore", "Errore richiesta");
          completer.completeError(error);
        }
      }
    );
    return completer.future;
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