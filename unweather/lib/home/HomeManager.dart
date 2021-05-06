import 'package:unweather/utils/Request.dart';
import 'package:unweather/utils/ResponseError.dart';

import 'model/HomeModel.dart';

class HomeManager {
  Future<HomeModel> featchData(String city) async {
    var response = await Request.get(
      route: "/data/2.5/forecast",
      params: {'q': city, 'units': 'metric', 'lang': 'it'},
    );

    if(response.statusCode == 200 && response.body["cod"] == "200"){
      return HomeModel.fromJson(response.body);
    } else {
      ResponseError error = ResponseError.fromJson(response.body);
      return Future<HomeModel>.error(error);
    }
  }
}