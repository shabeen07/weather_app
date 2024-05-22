

class WeatherResultError implements Exception {
  WeatherResultError({required this.message});

  /// create an Instance for API error response
  factory WeatherResultError.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> error = json['error'] as Map<String,dynamic>;
    return WeatherResultError(
      message: error['message'] as String,
    );
  }

  final String message;
}