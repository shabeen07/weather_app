import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherDisplayPage extends StatefulWidget {
  final WeatherModel weatherModel;

  const WeatherDisplayPage({super.key, required this.weatherModel});

  @override
  State<WeatherDisplayPage> createState() => _WeatherDisplayPageState();
}

class _WeatherDisplayPageState extends State<WeatherDisplayPage> {
  _WeatherDisplayPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentModel? currentModel = widget.weatherModel.current;
    LocationModel? locationModel = widget.weatherModel.location;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(locationModel?.name ?? ''),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildWeatherCondition(currentModel),
            _buildLocation(locationModel),
            _buildWeatherDetails(currentModel),
          ],
        ),
      ),
    );
  }

  /// build location details
  _buildLocation(LocationModel? locationModel) {
    if (locationModel == null) {
      return const Text('Location details not Found');
    }

    final region = locationModel.region ?? '';
    final country = locationModel.country ?? '';

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(locationModel.name ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
              const Icon(Icons.location_pin,size: 16,)
            ],
          ),
          Row(
            children: [
              region.isNotEmpty ?
              Text('$region, ' ) : const SizedBox(),
              Text(country),
            ],
          ),
          Text('Time: ${locationModel.localtime ?? ''}')
        ],
      ),
    );
  }

  /// build weather details
  _buildWeatherCondition(CurrentModel? currentModel) {
    if (currentModel == null) {
      return const Text('Weather details not Loaded');
    }

    ConditionModel? conditionModel = currentModel.condition;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Now',style: Theme.of(context).textTheme.titleMedium,),
                    Text(
                      "${currentModel.tempC ?? 0} °C",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge?.copyWith(
                        fontSize: 44.0
                      )
                    ),
                    const SizedBox(height: 8,),
                    (conditionModel != null)
                        ? Text(conditionModel.text ?? '',
                        style: Theme.of(context).textTheme.titleLarge)
                        : const SizedBox(),
                    const SizedBox(height: 2,),
                    Text('Feels Like: ${currentModel.feelsLikeC ?? 0} °C'),
                  ],
                ),
              ),
              Flexible(
                child: (conditionModel != null && conditionModel.icon != null)
                    ? Image.network(
                      'https:${conditionModel.icon}' ?? '',
                      height: 156,
                      width: 156,
                      fit: BoxFit.cover,
                    )
                    : const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

  /// build wind and Humidity details
  _buildWeatherDetails(CurrentModel? currentModel) {
    if (currentModel == null) {
      return const Text('Weather details not Loaded');
    }

    final humidity = currentModel.humidity ?? 0;
    final windKmp = currentModel.windKph ?? 0.0;
    final uv = currentModel.uv ?? 0.0;
    final pressure = currentModel.pressureMb ?? 0.0;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('Current Condition',style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(Icons.wind_power,size: 24,color: Theme.of(context).colorScheme.primary),
                          const SizedBox(height: 8,),
                          const Text('Wind'),
                          const SizedBox(height: 4,),
                          Text("${windKmp}km/h",style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(Icons.water_drop,size: 24,color: Theme.of(context).colorScheme.primary,),
                          const SizedBox(height: 8,),
                          const Text('Humidity'),
                          const SizedBox(height: 4,),
                          Text("$humidity%",style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(Icons.wb_sunny,size: 24,color: Theme.of(context).colorScheme.primary),
                          const SizedBox(height: 8,),
                          const Text('UV index'),
                          const SizedBox(height: 4,),
                          Text("$uv",style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Icon(Icons.wb_cloudy,size: 24,color: Theme.of(context).colorScheme.primary),
                          const SizedBox(height: 8,),
                          const Text('Pressure'),
                          const SizedBox(height: 4,),
                          Text("$pressure mBar",style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
