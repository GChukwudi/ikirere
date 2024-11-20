import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  final String apiKey = '7d83a6f1dfbf88feaa22ac24dd124785';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  late Map<String, dynamic> currentWeather;
  List<dynamic>? forecast;

  bool isLoading = false;

  Future<void> fetchCurrentWeather(String city) async {
    isLoading = true;
    notifyListeners();

    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    try {
      if (response.statusCode == 200) {
        currentWeather = json.decode(response.body);
        print(currentWeather);
      } else {
        currentWeather = {};
      }
    } catch (e) {
      print(e);
      currentWeather = {};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
