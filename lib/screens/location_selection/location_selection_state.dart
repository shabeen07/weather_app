part of 'location_selection_bloc.dart';

enum WeatherStatus { loading, loaded, error, unknown }

class LocationSelectionState extends Equatable {
  const LocationSelectionState._(
      {this.weatherModel = WeatherModel.empty,
      this.weatherStatus = WeatherStatus.unknown,
      this.error = ''});

  const LocationSelectionState.unknown() : this._();

  const LocationSelectionState.loading()
      : this._(weatherStatus: WeatherStatus.loading);

  const LocationSelectionState.loaded(WeatherModel weather)
      : this._(weatherStatus: WeatherStatus.loaded, weatherModel: weather);

  const LocationSelectionState.error(String error)
      : this._(weatherStatus: WeatherStatus.error, error: error);

  final WeatherStatus weatherStatus;
  final WeatherModel weatherModel;
  final String error;

  @override
  List<Object?> get props => [weatherStatus, weatherModel, error];
}
