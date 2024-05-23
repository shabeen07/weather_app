import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/location_selection/location_selection_bloc.dart';
import 'package:weather_app/routes/routes.dart';
import 'package:weather_app/theme/theme_cubit.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  /// text edit controller for city
  final controller = TextEditingController();

  /// form key for validation
  final _formKey = GlobalKey<FormState>();

  /// location suggestions
  static const locations = [
    'London',
    'Bangalore',
    'Seoul',
    'Mumbai',
    'Calicut',
    'Kolkata',
    'Kashmir',
    'New York',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'WEATHER',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary, letterSpacing: 2),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              tooltip: 'Change Theme',
              onPressed: () {
                /// toggle theme
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: context.watch<ThemeCubit>().isDarkMode

                  /// set icon based on Theme
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode))
        ],
      ),
      body: BlocListener<LocationSelectionBloc, LocationSelectionState>(
        listenWhen: (previous, current) =>
            previous.weatherStatus != current.weatherStatus,
        listener: (context, state) {
          /// navigate to weather display Page
          if (state.weatherStatus == WeatherStatus.loaded) {
            Navigator.of(context).pushNamed(AppRoutes.weatherDisplay,
                arguments: state.weatherModel);
          }

          /// show error dialog with response error msg
          if (state.weatherStatus == WeatherStatus.error) {
            showErrorDialog(context, "Weather Load Failed!", state.error);
          }
        },
        child: BlocBuilder<LocationSelectionBloc, LocationSelectionState>(
          buildWhen: (previous, current) =>
              previous.weatherStatus != current.weatherStatus,
          builder: (context, state) {
            if (state.weatherStatus == WeatherStatus.loading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Loading Weather Details...'),
                  ],
                ),
              );
            }
            return Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 156,
                        height: 156,
                        child: Lottie.asset('assets/anim/weather.json',
                            fit: BoxFit.fill),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the location or city you want check Weather!',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: controller,
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? "Enter a location or city"
                              : null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.clear(); // clear text
                              },
                              icon: const Icon(Icons.backspace),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Enter a location name'),
                        onFieldSubmitted: (value) {
                          _validateInput();
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            _validateInput();
                          },
                          child: Text('Get Weather'.toUpperCase())),
                      const SizedBox(height: 32),
                      Text(
                        'Location Suggestions',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                          runSpacing: 6.0,
                          children: locations
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: ActionChip(
                                      padding: const EdgeInsets.all(1),
                                      label: Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      avatar: null,
                                      onPressed: () {
                                        /// fetch weather from suggestions
                                        context
                                            .read<LocationSelectionBloc>()
                                            .add(FetchWeatherEvent(e));
                                      },
                                    ),
                                  ))
                              .toList()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Powered by',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            const Text('Weather API')
          ],
        ),
      ),
    );
  }

  void _validateInput() {
    /// validate input and call Fetch Weather event
    if (_formKey.currentState!.validate()) {
      context
          .read<LocationSelectionBloc>()
          .add(FetchWeatherEvent(controller.text));
    }
  }

  ///  show an Error dialog
  void showErrorDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            description,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("OK", style: TextStyle(fontSize: 18))),
          ],
        );
      },
    );
  }
}
