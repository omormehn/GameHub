import 'package:flutter/material.dart';



class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String _location = 'New York';
  String _weather = 'Sunny';

  void _switchLocation(String newLocation) {
    setState(() {
      _location = newLocation;
      // Update the weather data for the new location
      _weather = 'Rainy'; // Replace with actual weather data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Weather in $_location:'),
           Text(
              _weather,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold), // Define your own TextStyle
            ),
            DropdownButton<String>(
              value: _location,
              onChanged: (value) {
                _switchLocation(value!); // Use null safety operator (!)
              },
              items: [
                DropdownMenuItem(
                  child: Text('New York'),
                  value: 'New York',
                ),
                DropdownMenuItem(
                  child: Text('London'),
                  value: 'London',
                ),
                DropdownMenuItem(
                  child: Text('Paris'),
                  value: 'Paris',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
