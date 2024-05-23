class WeatherModel {
  final CurrentModel? current;
  final LocationModel? location;

  const WeatherModel({this.current, this.location});

  /// convert to weather model from json
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      current: json['current'] != null
          ? CurrentModel.fromJson(json['current'] as Map<String, dynamic>)
          : null,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }

  static const empty = WeatherModel();
}

class LocationModel {
  String? localtime;
  String? country;
  int? localtimeEpoch;
  String? name;
  double? lon;
  String? region;
  double? lat;
  String? tzId;

  LocationModel(
      {this.localtime,
      this.country,
      this.localtimeEpoch,
      this.name,
      this.lon,
      this.region,
      this.lat,
      this.tzId});

  /// convert to Location model from json
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        localtime: json['localtime'],
        country: json['country'],
        localtimeEpoch: json['localtime_epoch'],
        name: json['name'],
        lon: json['lon'],
        region: json['region'],
        lat: json['lat'],
        tzId: json['tz_id']);
  }
}

class CurrentModel {
  double? feelsLikeC;
  double? uv;
  String? lastUpdated;
  double? feelsLikeF;
  int? lastUpdatedEpoch;
  int? isDay;
  double? preIn;
  String? windDir;
  double? tempC;
  double? pressureIn;
  double? pressureMb;
  double? tempF;
  int? cloud;
  double? windKph;

  ConditionModel? condition;
  double? windMph;
  int? humidity;

  CurrentModel(
      {this.feelsLikeC,
      this.uv,
      this.lastUpdated,
      this.feelsLikeF,
      this.lastUpdatedEpoch,
      this.isDay,
      this.preIn,
      this.windDir,
      this.tempC,
      this.pressureIn,
      this.pressureMb,
      this.tempF,
      this.cloud,
      this.windKph,
      this.condition,
      this.windMph,
      this.humidity});

  /// convert to Current model from json
  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
        feelsLikeC: json['feelslike_c'],
        uv: json['uv'],
        lastUpdated: json['last_updated'],
        feelsLikeF: json['feelslike_f'],
        lastUpdatedEpoch: json['last_updated_epoch'],
        isDay: json['is_day'],
        preIn: json['precip_in'],
        windDir: json['wind_dir'],
        tempC: json['temp_c'],
        pressureIn: json['pressure_in'],
        pressureMb: json['pressure_mb'],
        tempF: json['temp_f'],
        cloud: json['cloud'],
        windKph: json['wind_kph'],
        condition: json['condition'] != null
            ? ConditionModel.fromJson(json['condition'] as Map<String, dynamic>)
            : null,
        windMph: json['wind_mph'],
        humidity: json['humidity']);
  }
}

class ConditionModel {
  int? code;
  String? icon;
  String? text;

  ConditionModel({this.code, this.icon, this.text});

  /// convert to Condition model from json
  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
        code: json['code'], icon: json['icon'], text: json['text']);
  }
}
