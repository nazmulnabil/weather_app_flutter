import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/modules/home/controller/home_controller.dart';
import '../model/City.dart';
import '../widget/weather_data_output.dart';


class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getInputSection(),
              SizedBox(height: 10,),
              Obx(()=>Get.find<HomeController>().isWeatherDataLoaded.value==true?WeatherDataOutput(weather: Get.find<HomeController>().weather!):Container())
          ],
        ),
      ),
    );
  }

  _getInputSection() {
    return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getCityDropdown(),
            ElevatedButton(onPressed: Get.find<HomeController>().showWeather, child: Text('VIEW WEATHER')),


          ],
        ));
  }

  DropdownButton<City> _getCityDropdown() {
    return DropdownButton<City>(
      value: Get.find<HomeController>().selectedCity,
      onChanged: (City? newCity) {
        setState(() {
          if (newCity != null) Get.find<HomeController>().selectedCity = newCity;
          print('view>>>>>>>>>>>>> $Get.find<HomeController>().selectedCity');
       Get.find<HomeController>().isWeatherDataLoaded.value = false;
        print(Get.find<HomeController>().isWeatherDataLoaded);
        });
      },
      items: Get.find<HomeController>().cityList.map((City city) {
        return DropdownMenuItem<City>(value: city, child: Text(city.name));
      }).toList(),
    );
  }
}