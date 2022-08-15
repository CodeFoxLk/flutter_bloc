import 'package:bloc_streams/events.dart';
import 'package:bloc_streams/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  AppBloc() : super(AppState.empty()) {
    on<FetchingCitiesEvent>(_onFetchingStart);
    on<OnFetchingDoneEvent>(_onFetchingDone);
  }

  void _onFetchingStart(
      FetchingCitiesEvent event, Emitter<AppState> emit) async {
    final cities = <String>[];
    try {
      await emit.onEach<String>(
        event.citiesStream.getCities(),
        onData: (city) {
          cities.add(city);
          emit(AppState(cities: cities));
        },
      );
       add(OnFetchingDoneEvent());
    } on StateError {
      print("State error");
    } catch (e) {
      print(e);
    }
     
    
  }

  void _onFetchingDone(OnFetchingDoneEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(onDoneMessage: 'All cities fetched'));
  }
}
