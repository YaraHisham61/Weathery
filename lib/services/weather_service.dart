import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '2d5bcc66c40d4f4fb35223724232010';
  WeatherService(this.dio);

  Future<WeatherModel> getForcast({required String cityName}) async {
    try {
      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1',
      );
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ?? 'oops something went wrong';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('oops something went wrong');
    }
  }
}
