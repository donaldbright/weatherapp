
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    title: 'Weather App',
    home: Home(),
  ) // Material App
);
  
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState (){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather () async {
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/weather?q=port%20harcourt&units=imperial&appid=6fc328e49a482df0af488a18bbcc5c4f');
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];

    });
  }

  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'City: Port Harcourt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38.0,
                    fontWeight: FontWeight.w600,
                  ), // TextStyle
                ), // Text
               ), // Padding
               Text(
                temp != null ? temp.toString() + '\u00B0': 'Loading',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 38.0,
                   fontWeight: FontWeight.w600,
                 ), // TextStyle
               ), // Text
               Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : 'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ), // TextStyle
                  ), // Text
               ), // Padding
              ], // <Widget>[]
            ) // Column
          ),// container
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text('Temperature'),
                    trailing: Text(temp != null ? temp.toString() + '\u00B0' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(description != null ? description.toString() : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity'),
                    trailing: Text(humidity != null ? humidity.toString() : 'Laoding')
                    ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing: Text(windspeed != null ? windspeed.toString() : 'Loading'),
                  ),
                ],
              )
            ), // Padding
          ) // Expanded
        ], // Widgets[]
      ), // column
    ); // Scarfold
  }
}