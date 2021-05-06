import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:unweather/home/HomeManager.dart';
import 'package:unweather/home/model/HomeModel.dart';
import 'package:unweather/home/viewModel/HomeViewModel.dart';
import 'package:unweather/utils/ResponseError.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  group('unweather', () {
    test("HomeViewModel", () async {
      await initializeDateFormatting('it_IT', null);
      HomeViewModel homeViewModel = HomeViewModel(manager: TestHomeManager());
      await homeViewModel.featchData(city: "Torino");
      expect(homeViewModel.city, "Torino");
      expect(homeViewModel.temperature, "19°");
      expect(homeViewModel.iconName, "assets/images/rain.png");
      expect(homeViewModel.day, "6");
      expect(homeViewModel.month, " Mag");
      expect(homeViewModel.maxTemperature, "max 19°");
      expect(homeViewModel.minTemperature, "min 11°");
      expect(homeViewModel.rain, "0.7 mm");
      expect(homeViewModel.windSpeed, "2.7 km/h");
      expect(homeViewModel.humidity, "45%");
      expect(homeViewModel.visibility, "10.0 km");
      expect(homeViewModel.cloudiness, "20%");
      expect(homeViewModel.pressure, "1007 hPa");
      expect(homeViewModel.isNight, false);
    });
  });
}

class TestHomeManager extends HomeManager {
  Future<HomeModel> featchData(String city) async {
    try {
      String data = await File("test/homeData.json").readAsString();
      return HomeModel.fromJson(jsonDecode(data));
    } catch (e) {
      print(e.toString());
      return Future<HomeModel>.error(ResponseError.fromJson({"cod": "500", "message": "error"}));
    }
  }
}