import 'dart:convert';

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

    /// if response is success ,then return [WeatherModel]
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
