

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/app_utils.dart';
import '../../../network/WeatherApi.dart';
import '../../../network/WeatherApiImpl.dart';
import '../model/City.dart';
import '../model/weather_data.dart';

class HomeController extends GetxController {
  List<City> cityList = [];
  City? selectedCity;
  RxBool isWeatherDataLoaded = false.obs;
  WeatherData? weather;
  late WeatherApi weatherApi;


  @override
  void onInit() {
    readCityList();

  weatherApi=WeatherApiImpl();

  }

 Future<WeatherData?> showWeather() async {
    try {
      var weatherTemp = await weatherApi.getWeatherInfo(selectedCity?.id);

      print(selectedCity?.name);

        weather = weatherTemp;

        isWeatherDataLoaded.value = true;
        print(isWeatherDataLoaded.value);
        update();
        print("inside controller");
        return weather;

    } catch (e) {
      //showSnackBar(context, e.toString(), type: SnackBarType.ERROR);

    }
    return null;
  }

  void readCityList() async {
    String response = await rootBundle.loadString('assets/city_list.json');
     final data = await json.decode(response) as List<dynamic>;
      cityList = data.map((city) => City.fromJson(city)).toList();
      selectedCity = cityList[0];

     }
}