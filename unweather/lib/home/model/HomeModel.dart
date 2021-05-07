import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  final String cod;
  final int message;
  final int cnt;
  final List<ListElement> list;
  final City city;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    cod: json["cod"] == null ? null : json["cod"],
    message: json["message"] == null ? null : json["message"],
    cnt: json["cnt"] == null ? null : json["cnt"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod == null ? null : cod,
    "message": message == null ? null : message,
    "cnt": cnt == null ? null : cnt,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
    "city": city == null ? null : city.toJson(),
  };
}

class City {
  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int timezone;
  final int sunrise;
  final int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    country: json["country"] == null ? null : json["country"],
    timezone: json["timezone"] == null ? null : json["timezone"],
    sunrise: json["sunrise"] == null ? null : json["sunrise"],
    sunset: json["sunset"] == null ? null : json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "coord": coord == null ? null : coord.toJson(),
    "country": country == null ? null : country,
    "timezone": timezone == null ? null : timezone,
    "sunrise": sunrise == null ? null : sunrise,
    "sunset": sunset == null ? null : sunset,
  };
}

class Coord {
  Coord({
    this.lat,
    this.lon,
  });

  final double lat;
  final double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
  };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain rain;
  final Sys sys;
  final DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"] == null ? null : json["dt"],
    main: json["main"] == null ? null : Main.fromJson(json["main"]),
    weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
    visibility: json["visibility"] == null ? null : json["visibility"],
    pop: json["pop"] == null ? null : json["pop"].toDouble(),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt == null ? null : dt,
    "main": main == null ? null : main.toJson(),
    "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds == null ? null : clouds.toJson(),
    "wind": wind == null ? null : wind.toJson(),
    "visibility": visibility == null ? null : visibility,
    "pop": pop == null ? null : pop,
    "rain": rain == null ? null : rain.toJson(),
    "sys": sys == null ? null : sys.toJson(),
    "dt_txt": dtTxt == null ? null : dtTxt.toIso8601String(),
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  final int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"] == null ? null : json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all == null ? null : all,
  };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
    tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"],
    seaLevel: json["sea_level"] == null ? null : json["sea_level"],
    grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
    humidity: json["humidity"] == null ? null : json["humidity"],
    tempKf: json["temp_kf"] == null ? null : json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "temp_min": tempMin == null ? null : tempMin,
    "temp_max": tempMax == null ? null : tempMax,
    "pressure": pressure == null ? null : pressure,
    "sea_level": seaLevel == null ? null : seaLevel,
    "grnd_level": grndLevel == null ? null : grndLevel,
    "humidity": humidity == null ? null : humidity,
    "temp_kf": tempKf == null ? null : tempKf,
  };
}

class Rain {
  Rain({
    this.threeH,
  });

  final double threeH;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    threeH: json["3h"] == null ? null : json["3h"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": threeH == null ? null : threeH,
  };
}

class Sys {
  Sys({
    this.pod,
  });

  final String pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json["pod"] == null ? null : json["pod"],
  );

  Map<String, dynamic> toJson() => {
    "pod": pod == null ? null : pod,
  };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : json["main"],
    description: json["description"] == null ? null : json["description"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "main": main == null ? null : main,
    "description": description == null ? null : description,
    "icon": icon == null ? null : icon,
  };
}

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  final double speed;
  final int deg;
  final double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"] == null ? null : json["speed"].toDouble(),
    deg: json["deg"] == null ? null : json["deg"],
    gust: json["gust"] == null ? null : json["gust"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed == null ? null : speed,
    "deg": deg == null ? null : deg,
    "gust": gust == null ? null : gust,
  };
}
