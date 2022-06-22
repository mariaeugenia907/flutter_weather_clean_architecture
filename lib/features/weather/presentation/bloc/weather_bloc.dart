import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_clean_architecture/features/weather/presentation/bloc/weather_event.dart';
import 'package:flutter_weather_clean_architecture/features/weather/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;

  WeatherBloc(this._getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        final cityName = event.cityName;

        emit(WeatherLoading());

        final result = await _getCurrentWeather.execute(cityName);
        result.fold(
          (failure) {
            emit(WeatherError(failure.message));
          },
          (data) {
            emit(WeatherHasData(data));
          },
        );
      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}