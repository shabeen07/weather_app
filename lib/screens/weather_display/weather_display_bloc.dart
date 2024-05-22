import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'weather_display_event.dart';
part 'weather_display_state.dart';

class WeatherDisplayBloc extends Bloc<WeatherDisplayEvent, WeatherDisplayState> {
  WeatherDisplayBloc() : super(WeatherDisplayInitial()) {
    on<WeatherDisplayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
