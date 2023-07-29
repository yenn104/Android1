// ignore_for_file: avoid_print, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';
import '../../repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);

      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
      print('state: $state');
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
      // ignore: avoid_print
      print('state: $state');
    }
  }
}
