import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/presentation/cubit/weather_cubit/weather_state.dart';
import 'package:weather_app/presentation/screens/home/widgets/body_home.dart';
import 'package:weather_app/presentation/screens/home/widgets/header_home.dart';
import 'package:weather_app/presentation/screens/home/widgets/weather_each_time.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          SingleChildScrollView(child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: const Center(
                child: Text('Fetching weather...'),
              ),
            );
          } else if (state is WeatherSuccessState) {
            return Column(
              children: [
                HeaderHomeWidget(
                  weather: state.weather!,
                ),
                BodyHomeWidget(
                  weather: state.weather!,
                ),
                const SizedBox(
                  height: 120,
                ),
                WeatherForecastWidget(
                  lstWeather: state.listWeatherForecast ?? [],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ))),
    );
  }
}
