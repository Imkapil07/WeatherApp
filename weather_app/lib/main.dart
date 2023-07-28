import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/views/additional_information.dart';
import 'package:weather_app/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), 
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Now let's test if everything work ,, we will call the api in init state fuction
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   client.getCurrentWeather("Georgia");

  // }

  Future<void> getData() async {
    //data = await client.getCurrentWeather("Georgia");
    data = await client.getCurrentWeather("Bhopal");
    // data = await client.getCurrentWeather("Georgia");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          elevation: 0.0,
          title: const Text(
            "Weather Apppp",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    curentWeather(Icons.wb_sunny_rounded, "${data!.temp}°",
                        "${data!.cityname}"),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xdd212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20.0,
                    ),
                    additionalInformation("${data!.wind}", "${data!.humidity}",
                        "${data!.pressure}", "${data!.feels_like}"),
                  ],
                );
              }
              return Container();
            }));
  }
}
