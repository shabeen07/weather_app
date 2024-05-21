import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/location_selection/location_selection.dart';
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
            theme: state, /// set the from bloc
            home: const LocationSelectionPage(),
          );
        },
      ),
    );
  }
}