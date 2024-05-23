import 'dart:convert';

import 'package:weather_app/models/weather_error_result.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseURL =
      "http://api.weatherapi.com/v1/current.json?";
  final String apiKey = "0e52f157a39d450fa28193302242105";

  /// get Weather from Weather API
  Future<WeatherModel> getWeather(String location) async {
    final response =
        await http.get(Uri.parse("${baseURL}key=$apiKey&q=$location"));
    Map<String,dynamic> result = jsonDecode(response.body);

    /// if response is success ,then return [WeatherModel]
    if (response.statusCode == 200) {
      print(result.toString());
      return WeatherModel.fromJson(result);
    }else{
      /// throw weather result error
      throw WeatherResultError.fromJson(result);
    }
  }
}
