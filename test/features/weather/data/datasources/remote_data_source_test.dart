import 'dart:convert';
import 'package:flutter_weather_clean_architecture/core/constants.dart';
import 'package:flutter_weather_clean_architecture/core/errors/exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_clean_architecture/features/weather/data/datasources/remote_data_source.dart';
import 'package:flutter_weather_clean_architecture/features/weather/data/models/weather_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/json/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('obter o clima atual', () {
    final tCityName = 'Teresina';
    final tWeatherModel = WeatherModel.fromJson(json
        .decode(readJson('helpers/json/weather.json')));

    test(
      'deve retornar o modelo climático quando o código de resposta for 200',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
        ).thenAnswer(
          (_) async => http.Response(
              readJson('helpers/json/weather.json'), 200),
        );

        final result = await dataSource.getCurrentWeather(tCityName);

        expect(result, equals(tWeatherModel));
      },
    );

    test(
      'deve lançar uma server exception quando o código de resposta for 404 ou outro',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        final call = dataSource.getCurrentWeather(tCityName);

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}