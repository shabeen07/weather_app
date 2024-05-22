part of 'location_selection_bloc.dart';

class LocationSelectionEvent {

}

class FetchWeatherEvent extends LocationSelectionEvent{
  final String locationName;

  FetchWeatherEvent(this.locationName);
}
