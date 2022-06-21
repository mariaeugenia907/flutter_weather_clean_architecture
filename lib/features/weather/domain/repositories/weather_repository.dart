import 'package:dartz/dartz.dart';
import 'package:flutter_weather_clean_architecture/core/errors/failure.dart';
import 'package:flutter_weather_clean_architecture/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
