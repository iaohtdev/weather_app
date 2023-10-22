import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/home/home_screen.dart';
import 'package:weather_app/service/position_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: FutureBuilder(
            future: PositionService().determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BlocProvider(
                  create: (context) {
                    return WeatherCubit()
                      ..fetchWeather(
                          lat: snapshot.data?.latitude,
                          long: snapshot.data?.longitude);
                  },
                  child: const HomeScreen(),
                );
              } else {
                return const Scaffold(
                  body: Center(child: Text('Get current location...')),
                );
              }
            },
          ),
        ));
  }
}
