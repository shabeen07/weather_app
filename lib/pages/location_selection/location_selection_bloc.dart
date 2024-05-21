import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

part 'location_selection_event.dart';
part 'location_selection_state.dart';

class LocationSelectionBloc
    extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  LocationSelectionBloc({required WeatherService service})
      : _weatherService = service,
        super(const LocationSelectionState.unknown()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  final WeatherService _weatherService;

  Future<void> _onFetchWeather(FetchWeatherEvent event,
      Emitter<LocationSelectionState> emit) async {
    /// set loading state
    emit(const LocationSelectionState.loading());
    /// add some delay
    await Future<void>.delayed(const Duration(milliseconds: 200));
    try{
      WeatherModel weatherModel = await _weatherService.getWeather(event.locationName);
      /// set loaded state with WeatherModel
      return emit(LocationSelectionState.loaded(weatherModel));
    }catch(e){
      /// catch Exception , and set error state
      return emit(LocationSelectionState.error(e.toString()));
    }
  }
}
