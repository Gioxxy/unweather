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
    month = " " + DateFormat("MMM", "it_IT").format(model.list.first.dtTxt);
    maxTemperature = "max " + model.list.first.main.tempMax.round().toString() + "°";
    minTemperature = "min " + model.list.first.main.tempMin.round().toString() + "°";
    rain = (model.list.first.rain?.threeH ?? 0).toString() + " mm";
    windSpeed = ((model.list.first.wind?.speed ?? 0) * 3.6).toString() + " km/h";
    humidity = (model.list.first.main.humidity ?? 0).toString() + "%";
    visibility = ((model.list.first.visibility ?? 0)/1000).toString() + " km";
    cloudiness = (model.list.first.clouds.all ?? 0).toString() + "%";
    pressure = (model.list.first.main.pressure ?? 0).toString() + " hPa";
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
}