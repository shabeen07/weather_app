import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'location_selection_event.dart';
part 'location_selection_state.dart';

class LocationSelectionBloc extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  LocationSelectionBloc() : super(LocationSelectionInitial()) {
    on<LocationSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
