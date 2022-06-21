import 'package:flutter_weather_clean_architecture/features/weather/data/datasources/remote_data_source.dart';
import 'package:flutter_weather_clean_architecture/features/weather/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  WeatherRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}