import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
   LocationScreen({this.locationweather});

   final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel=WeatherModel();
  int temp;
  String city;
  String Wicon;
  String message;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
  }

  void updateUI(dynamic weatherdata)
  {
    setState(() {
      if(weatherdata==null){
          temp=0;
          Wicon='Error';
          message='Unable to get search GPS';
          city='';
          return;
      }
      int icon= (weatherdata)['weather'][0]['id'];
      temp=(weatherdata)['main']['temp'].toInt();
      city=(weatherdata)['name'];

      Wicon=weatherModel.getWeatherIcon(icon);
      message=weatherModel.getMessage(temp);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{

                  var weatherData=await weatherModel.getLocationWeather();
                  updateUI(weatherData);
                  print('yep');
                                  },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var typedName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }
                      ));
                     if(typedName!=null){
                      var weatherdata = await weatherModel.getCityWeather(typedName);
                       updateUI(weatherdata);
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      Wicon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//