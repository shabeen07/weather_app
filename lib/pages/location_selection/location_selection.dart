import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/theme/theme_cubit.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'WEATHER',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 2),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              tooltip: 'Change Theme',
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();

                /// toggle theme
              },
              icon: context.watch<ThemeCubit>().isDarkMode

                  /// set icon based on Theme
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode))
        ],
      ),
    );
  }
}
