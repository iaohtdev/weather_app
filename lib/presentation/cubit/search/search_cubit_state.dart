part of 'search_cubit_cubit.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  Weather? weather;

  SearchSuccessState({this.weather});
}

class SearchFailedState extends SearchState {
  final String error;

  SearchFailedState(this.error);
}
