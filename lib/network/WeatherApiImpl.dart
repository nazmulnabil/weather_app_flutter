import 'package:weather_app_flutter/config/build_config.dart';
import 'package:weather_app_flutter/network/WeatherApi.dart';
import 'package:weather_app_flutter/network/dio_client.dart';

import '../modules/home/model/weather_data.dart';
import '../modules/home/model/weather_response.dart';


class WeatherApiImpl extends WeatherApi {
  var logger = BuildConfig.instance.config.logger;

  @override
  Future<WeatherData>? getWeatherInfo(int? cityId) {
    return _getWeather(cityId);
  }

  Future<WeatherData> _getWeather(int? cityId) async {
    try {
      var dioClient = DioClient().client;
      var response = await dioClient.get(
        '/weather',
        queryParameters: {'id': cityId},
      );

      logger.i("city Response body JSON:\n$response");

      WeatherResponse weatherResponse = WeatherResponse.fromJson(response.data);

      logger.i("Response body JSON:\n$weatherResponse");

      WeatherData weatherData = weatherResponse.toWeatherData();
      print(weatherData.cityAndCountry) ;

      print("from network $weatherData");

      return weatherData;
    } catch (e) {
      throw e;
    }
  }
}
