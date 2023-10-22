import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubit/search/search_cubit_cubit.dart';
import 'package:weather_app/shared/common.dart';
import 'package:weather_app/shared/helper/image_helper.dart';

class SearchPlaceScreen extends StatefulWidget {
  const SearchPlaceScreen({super.key});

  @override
  State<SearchPlaceScreen> createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color(0xff0C4F67),
                )),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'What city do you want to know weather?',
                      style: AppCommon.appTextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff0C4F67).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        ImageHelper.getImage(
                            folderName: ImagePath.icons,
                            height: 25,
                            iconName: ImageName.iconSearch),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                    hintText: 'City name',
                                    border: InputBorder.none),
                                onSubmitted: (value) {},
                                onChanged: (value) {
                                  context
                                      .read<SearchCubit>()
                                      .searchWeatherByCity(value);
                                })),
                        if (_searchController.text.isNotEmpty)
                          InkWell(
                              onTap: () {
                                _searchController.clear();
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                              ))
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SearchSuccessState) {
                          final weather = state.weather;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Result',
                                style: AppCommon.appTextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context, weather);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        weather?.areaName ?? '',
                                        style: AppCommon.appTextStyle(
                                            fontSize: 16),
                                      ),
                                    ],
                                  )),
                            ],
                          );
                        } else if (state is SearchFailedState) {
                          return const Text('city not found');
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
