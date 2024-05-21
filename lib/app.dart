import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/location_selection/location_selection.dart';
import 'package:weather_app/pages/location_selection/location_selection_bloc.dart';
import 'package:weather_app/pages/weather_display/weather_display.dart';
import 'package:weather_app/pages/weather_display/weather_display_bloc.dart';
import 'package:weather_app/routes/routes.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/theme/light_mode.dart';
import 'package:weather_app/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// wrap entire app with Theme Bloc , to listen changes and update theme
    return BlocProvider(
      create: (context) => ThemeCubit(lightMode),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather',
            theme: state,
            initialRoute: AppRoutes.locationSelection,
            routes: _onGenerateRoutes(context),
          );
        },
      ),
    );
  }

  /// on generate named routes
  _onGenerateRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      AppRoutes.locationSelection: (context) =>
          _buildLocationSelection(context),
      AppRoutes.weatherDisplay: (context) => _buildWeatherDisplay(context),
    };
  }

  /// build location selection page with Bloc
  _buildLocationSelection(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationSelectionBloc(service: WeatherService()),
      child: const LocationSelectionPage(),
    );
  }

  /// build Weather Display page with Bloc
  _buildWeatherDisplay(BuildContext context) {
    /// get weather model from route argument
    WeatherModel weatherModel =
        ModalRoute.of(context)?.settings.arguments as WeatherModel;
    return BlocProvider(
      create: (context) => WeatherDisplayBloc(),
      child: WeatherDisplayPage(weatherModel: weatherModel),
    );
  }
}
