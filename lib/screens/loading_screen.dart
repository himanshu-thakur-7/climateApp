import 'package:clima/screens/location_screen.dart';

import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = 'e5696ed5e4fa5b43da364aee9285f428';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocationData();

  }
  void getLocationData()async{

    WeatherModel weatherModel=WeatherModel();

    var weatherData=await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(
        locationweather: weatherData,
      );
    }));
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        )
      ),
    );
  }
}
